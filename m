Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVDHXJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVDHXJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVDHXJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:09:22 -0400
Received: from smtp2.primushost.com ([209.58.220.66]:25587 "EHLO
	smtp2.primushost.com") by vger.kernel.org with ESMTP
	id S261186AbVDHXJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:09:03 -0400
Message-ID: <42570F07.6080406@shore.net>
Date: Fri, 08 Apr 2005 19:08:55 -0400
From: "Eric A. Cottrell" <eac@shore.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LIBATA AHCI engine timeout hang with ATAPI devices
References: <4256D1A9.6080401@shore.net> <4256D7CA.7030908@pobox.com>
In-Reply-To: <4256D7CA.7030908@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> You need something like the attached patch.
> 
> In general, ATAPI is still very much experimental at this point.  One 
> known bug that affects libata is that ATAPI DMA is not aligned to a 
> 4-byte boundary.
> 
Hello,

Thanks.

I already have that patch applied.  I will poke around the code over the weekend and see if I can figure out the problem.
I am alittle rusty as my last disk driver code was modifying Heathkit CPM BIOS to support a SMS SASI board for 8 inch floppies and 
Shugart SA1000 series hard drives!

I would like to help get ATAPI to work as I suspect more SATA ATAPI stuff will appear as motherboards use SATA.  It appears that the 
ahci/libata code is missing some needed steps that the ata_piix/libata code does.  Looking at the code and patches I can see that 
libata had to change to permit the hardware to perform tasks that libata did.

Thank you for your web page on IDE drives.  I downloaded alot of specs and even read a small bit of them.

73 Eric eac@shore.net
