Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266452AbUAOEFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 23:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266455AbUAOEFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 23:05:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53911 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266452AbUAOEFm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 23:05:42 -0500
Message-ID: <40061188.8060705@pobox.com>
Date: Wed, 14 Jan 2004 23:05:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kieran Morrissey <linux@mgpenguin.net>
CC: greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c for
  long device names.
References: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net>
In-Reply-To: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kieran Morrissey wrote:
> Hi all and sundry..
> 
> Although /proc/pci and by extension the name database is allegedly 
> legacy and therefore deprecated, some (including myself) still use it 
> for things such as phpSysInfo, and the still-widespread usage of it is 
> obvious in the regularity of slight patches to pci.ids. So, this is an 
> all-inclusive patch to bring things up to date:
> 
> * Updates pci.ids with a snapshot from http://pciids.sourceforge.net/ as 
> at 14 Jan 04.
> * Fixes gen-devlist.c to truncate long device names rather than reject 
> the whole database
>   (previously the latest databases had some devices that were too long 
> and caused a kernel with the latest db to fail to compile)


Well, appreciated, but we really do need to remove it.  We don't need 
these strings in the kernel at all.  pci.ids is just a static lookup 
table that is best kept in userspace.

	Jeff



