Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbTCPBgi>; Sat, 15 Mar 2003 20:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbTCPBgh>; Sat, 15 Mar 2003 20:36:37 -0500
Received: from dp.samba.org ([66.70.73.150]:31707 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261984AbTCPBgf>;
	Sat, 15 Mar 2003 20:36:35 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15987.54885.269534.490554@nanango.paulus.ozlabs.org>
Date: Sun, 16 Mar 2003 12:41:57 +1100 (EST)
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: bitmaps/bitops
In-Reply-To: <200303160131.h2G1V3B10636@devserv.devel.redhat.com>
References: <mailman.1047762781.3457.linux-kernel2news@redhat.com>
	<200303160131.h2G1V3B10636@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev writes:

> > but the prototype for test_and_set_bit() depends on $(ARCH), and it's
> > not consistent, with the second arg (bitmap address) being one of:
> >   volatile void *
> >   void *
> >   volatile unsigned long *
> 
> It should be unsigned long pointer. I have no idea why
> volatile is still alive. Perhaps Linus can remember why he
> left it in on is386. Other arch maintainers midnlessly ape him
> in this area. I think I even kept his e-mail where he explains
> why volatile has to go.

The volatile is there (at least in ppc) because without it you get
compile warnings.  I don't see why the bitops particularly should be
the anti-volatile police.  I agree that using volatile is usually a
bad idea (unless you are accessing a memory-mapped I/O device).

Paul.
