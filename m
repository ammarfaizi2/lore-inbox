Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTEOUOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTEOUOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:14:52 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:28174 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264245AbTEOUOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:14:51 -0400
Date: Thu, 15 May 2003 21:27:38 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK FBDEV] String drawing optimizations.
In-Reply-To: <20030513003427.GA19121@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0305152104400.6330-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What about getting rid of one-char putc, implementing it in terms of
> putcs? I'm doing it in matroxfb patches, and nobody complained yet, and
> with current length of {fbcon,accel}_putc{s,} I was not able to find
> measurable speed difference between putc and putc through putcs variants.

Hm. I compressed all the image drawing functions into accel_putcs which is 
used in many places. I then placed accel_putc() into fbcon_putc(). I could 
have accel_putcs() called in fbcon_putc(). The advantage is smaller 
amount of code. The offset is a big more overhead plus a function call. 
What do people think here?


