Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWCPSec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWCPSec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWCPSec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:34:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2795 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964822AbWCPSeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:34:31 -0500
Subject: Re: VMI Interface Proposal Documentation for I386, Part 4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4419845E.8060904@vmware.com>
References: <4415CE1C.1060608@vmware.com> <20060315233703.GE1919@elf.ucw.cz>
	 <1142522308.13318.29.camel@localhost.localdomain>
	 <4419845E.8060904@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Mar 2006 18:40:50 +0000
Message-Id: <1142534450.13318.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-16 at 07:29 -0800, Zachary Amsden wrote:
> quite easy.  I would argue that the various CMOS timer update utilities 
> in userspace that do this same thing, really should be moved into the 
> kernel as fast as possible - they could race against other CPUs in 

They were, something like 8-10 years ago. If your distributor is
shipping code that is doing cli in user space please assist in their
re-education. Several ship code which can fall back if the nvram or rtc
driver is missing but thats compat code.

> Good to know.  I thought some piece of xinit still used it to do 
> dot-clock probing - but I could be wrong.  

It does, but it doesn't disable interrupts. You don't need to.

