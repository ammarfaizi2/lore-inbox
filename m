Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVADWiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVADWiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVADWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:36:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:22932 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262398AbVADWfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:35:13 -0500
Date: Tue, 4 Jan 2005 14:35:10 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Nikita Danilov <nikita@clusterfs.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove duplicated patch fragment
Message-ID: <20050104143510.G469@build.pdx.osdl.net>
References: <200501040611.j046BHoq005158@hera.kernel.org> <m14qhxmkw4.fsf@clusterfs.com> <20050104172614.GB12861@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050104172614.GB12861@apps.cwi.nl>; from Andries.Brouwer@cwi.nl on Tue, Jan 04, 2005 at 06:26:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer (Andries.Brouwer@cwi.nl) wrote:
> On Tue, Jan 04, 2005 at 03:36:11PM +0300, Nikita Danilov wrote:
> > On another account, shouldn't capable(CAP_SYS_ADMIN) checks in
> > cap_vm_enough_memory() be replaced with capable(CAP_SYS_RESOURCE):
> > (CAP_SYS_RESOURCE is used by file systems to control reserved disk
> > blocks)?
> 
> The use of current->euid comes from the use of current->euid in dummy.c
> a few lines higher up in the same routine.
> The use of CAP_SYS_ADMIN comes from the use of CAP_SYS_ADMIN in
> commoncap.c a few lines higher up in the same routine.
> 
> I have no strong opinion about what is best.

Unfortunately, this what committed on 2003/05/25 (IOW, it's been in
there since 2.5.70).  So, we can't really change that w/out possibly
breaking things.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
