Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270750AbTHOTcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270755AbTHOTci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:32:38 -0400
Received: from mrout1.yahoo.com ([216.145.54.171]:19722 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S270750AbTHOTch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:32:37 -0400
Message-ID: <3F3D354E.80905@bigfoot.com>
Date: Fri, 15 Aug 2003 12:32:30 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SOLVED: Re: SATA (Serial ATA) support in 2.4.x?
References: <3F217BE8.5070807@bigfoot.com> <20030725193548.GA14017@gtf.org> <3F2AF529.3040100@bigfoot.com>
In-Reply-To: <3F2AF529.3040100@bigfoot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Steffl wrote:
> Jeff Garzik wrote:
> 
>> On Fri, Jul 25, 2003 at 11:50:16AM -0700, Erik Steffl wrote:
>>
>>>  I am specifically interested whether it should support disks above 
>>> 137GB (as I have problems accessing anything above 137GB on 250GB 
>>> SATA drive)
>>
>>
>>
>> It should.
>>
>> I will be testing this when I return from OLS, next week.

   just in case anybody's searching the archives:

   I got the following advice from Jeff Garzik and it worked (didn't do 
much testing yet, but at least the whole disk is usable):

   2.4.21-ac4 (vanilla plus ac4 patches)

   create another vanilla tree with libata5 patches, then copy the 
following files to ac4 tree: drivers/scsi/{ata_piix,libata}.c and 
include/linux/ata.h

   build with scsi ata support (make sure you have bios set so that sata 
drives are seen as sata drives, not legacy ide drives, I only got 
machines lockups in legacy mode). The disks should be visible as scis 
disk (/dev/sd[a-z]).

   libata5 patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-libata5.patch.bz2

	erik


