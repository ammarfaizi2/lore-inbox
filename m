Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbTIHP7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbTIHP7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:59:52 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:10627 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262541AbTIHP7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:59:51 -0400
Subject: Re: [2.4.23-pre3] Possible bug in fs/buffer.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <je3cf7uw0f.fsf@sykes.suse.de>
References: <200309081715.09657@bilbo.math.uni-mannheim.de>
	 <je3cf7uw0f.fsf@sykes.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063036721.21084.55.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 16:58:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 16:42, Andreas Schwab wrote:
> It's neither ugly, nor bogus.  The only 100% reliable way to assign the
> maximum value to an unsigned integer is to use -1.

Its not 100% reliable either 8). Properly you should use the limits.h
values. The kernel assumes 2's complement so just adding a cast would
probably keep gcc happy

