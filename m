Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263793AbUDVDFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUDVDFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbUDVDFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:05:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:5869 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263793AbUDVDFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:05:34 -0400
Date: Wed, 21 Apr 2004 20:05:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: ext3 reservation question.
In-Reply-To: <200404211655.47329.pbadari@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0404211959560.18945@ppc970.osdl.org>
References: <200404211655.47329.pbadari@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Apr 2004, Badari Pulavarty wrote:
> 
> I am worried about a case, where multiple threads writing to 
> different parts of same file - there by each thread thrashing 
> reservation window (since each one has its own goal).

Didn't we have a patch two years ago or something floating around with
doing lazy (delayed) block allocation on ext2 - doing the actual
allocation only when writing the thing out? Then you shouldn't have this
problem under any normal load, hopefully.

Or was it just some idle discussion that I remember?

		Linus
