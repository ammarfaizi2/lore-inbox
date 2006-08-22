Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWHVTJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWHVTJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWHVTJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:09:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52875 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751163AbWHVTJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:09:22 -0400
Subject: Re: [PATCH] paravirt.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1156271386.2976.102.camel@laptopd505.fenrus.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>
	 <1156271386.2976.102.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Aug 2006 20:30:04 +0100
Message-Id: <1156275004.27114.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-22 am 20:29 +0200, ysgrifennodd Arjan van de Ven:
> > And it doesn't work for VMI or lhype, both of which might modify 
> > paravirt_ops way later in the boot process, when loaded as a module.  
> 
> doesn't this then start to have the same issues that runtime patching
> the system call table had?

It has several I can see that are if anything worse

- Stacked hypervisors stomping each others functions
- Locking required to do updates: and remember our lock functions use
methods in the array
- If we boot patch inline code to get performance natively its almost
impossible to then revert that.


