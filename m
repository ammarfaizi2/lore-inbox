Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbUKQR1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUKQR1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUKQRYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:24:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:2733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262415AbUKQQzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:55:31 -0500
Date: Wed, 17 Nov 2004 08:55:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: linux-dev@morknet.de, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: [PATCH] dss1_divert ISDN module compile fix for kernel 2.6.8.1
In-Reply-To: <58cb370e0411170828365d1982@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0411170853420.2222@ppc970.osdl.org>
References: <419B662D.5020904@morknet.de> <58cb370e0411170828365d1982@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Nov 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> This looks wrong, you are using many private spinlocks instead
> of one global spinlock.

Good catch, I didn't look closely enough.

Steffen, can you make that "divert_lock" one global one, and re-test? I'd 
do it myself, but it really does need testing, since there might be a 
deadlock lurking there that the local lock bug hid.

		Linus
