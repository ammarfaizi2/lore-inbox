Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVEMTxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVEMTxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVEMTtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:49:36 -0400
Received: from animx.eu.org ([216.98.75.249]:63636 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262474AbVEMTrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:47:22 -0400
Date: Fri, 13 May 2005 15:45:49 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>,
       linux@dominikbrodowski.net
Subject: Re: [PATCH] pcmcia/ds: handle any error code
Message-ID: <20050513194549.GB3519@animx.eu.org>
Mail-Followup-To: randy_dunlap <rdunlap@xenotime.net>,
	linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>,
	linux@dominikbrodowski.net
References: <20050512015220.GA31634@animx.eu.org> <20050512230206.GA1380@animx.eu.org> <20050512222038.325081b2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512222038.325081b2.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:
> On Thu, 12 May 2005 19:02:06 -0400 Wakko Warner wrote:
> There is some small difference in locking in fs/char_dev.c between
> 2.6.12-rc4 and 2.6.11.8, but I don't yet see why it would cause a
> failure in register_chrdev().
> 
> Oh, there's a big difference in drivers/pcmcia/ds.c, lots of probe
> changes.  This is where to look further (but not tonight).
> The question then becomes is this a real regression?
> 
> Do you suspect a problem with -Os code generation?

I just tried it, it doesn't give me any errors.  This is strange considering
that I a) use a pristine tree for each kernel (only coping the .config) and
b) the patch doesn't do anything except report the error.  I made my boot
floppy (the scripts I use pull from the kernel tree I specify and make the
image I need) and booted from it.  I placed the modules on my stage2 disk
that was made and it works.

I don't have the time this week to try again from scratch.  I'll see if I
can do it next week.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
