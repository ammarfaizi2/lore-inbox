Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVEXSsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVEXSsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVEXSsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:48:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14489 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261353AbVEXSsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:48:19 -0400
Date: Tue, 24 May 2005 20:47:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: Emilyr@us.ibm.com, James Morris <jmorris@redhat.com>, Kylene@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       Toml@us.ibm.com, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
Message-ID: <20050524184752.GB2268@elf.ucw.cz>
References: <Pine.WNT.4.63.0505240841220.3152@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0505240841220.3152@laptop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * remove all the buffer overflows. I.e. if grub contains buffer
> >    overflow in parsing menu.conf... that is not a security hole
> >    (as of now) because only administrator can modify menu.conf.
> >    With IMA enabled, it would make your certification useless...
> 
> Taking your example: Even if you run a buffer-overflow grub, IMA will 
> enable remote parties to differentiate between systems that run
> the vulnerable grub and systems that don't. IMA in this case actually
> can put value to running better software.

Yes, but see above: that buffer overflow in grub was *not* a
vulnerability... not until you introduce IMA.

That is my biggest concern. You are completely changing rules for
userland code. Buffer overflow that only root could exploit used to be
okay. It used to be okay to read config files without communicating
with TPM.
								Pavel

