Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWGHWE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWGHWE2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWGHWE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:04:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751069AbWGHWE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:04:27 -0400
Date: Sat, 8 Jul 2006 15:04:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org,
       Thomas Kleffel <tk@maintech.de>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: pcmcia IDE broken in 2.6.18-rc1
Message-Id: <20060708150414.6e1089f2.akpm@osdl.org>
In-Reply-To: <1152394547.27368.32.camel@localhost.localdomain>
References: <20060708145541.GA2079@elf.ucw.cz>
	<1152380199.27368.9.camel@localhost.localdomain>
	<20060708104100.af5dcbd8.akpm@osdl.org>
	<1152394547.27368.32.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Jul 2006 22:35:47 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Sad, 2006-07-08 am 10:41 -0700, ysgrifennodd Andrew Morton:
> > +      	    io_base = (unsigned long) ioremap(req.Base, req.Size);
> > +    	    ctl_base = io_base + 0x0e;
> > +    	    is_mmio = 1;
> 
> Where does this get unmapped ?

I don't think it does. (drivers/ide/legacy/ide-cs.c:312)

