Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945978AbWBOPWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945978AbWBOPWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945981AbWBOPWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:22:05 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:21915 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1945978AbWBOPWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:22:01 -0500
Message-ID: <43F346DA.4020404@cfl.rr.com>
Date: Wed, 15 Feb 2006 10:20:58 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>  <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>  <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>  <43F2E8BA.90001@bfh.ch>  <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140012392.14831.13.camel@localhost.localdomain>
In-Reply-To: <1140012392.14831.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 15:23:33.0682 (UTC) FILETIME=[C8A0D920:01C63243]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14269.000
X-TM-AS-Result: No--3.700000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2006-02-15 at 10:01 +0100, Seewer Philippe wrote:
>   
>> This would mean dropping the HDIO_GETGEO ioctl completely and force
>> applications such as fdisk/sfdisk and even dosemu to determine disk
>> geometry for themselves. Which I think actually would be the most
>> correct approach.
>>     
>
> In the IDE case the drive geometry has meaning in certain cases,
> specifically the C/H/S drive addressing case with old old drives. 

I thought that C/H/S addressing was purely a function of int 13, not the 
hardware interface?  If it is a function of some older hardware 
interfaces, then we are still talking about two different, and likely 
incompatible geometries:  the one the disk reports, and the one the bios 
reports.  The values in the MBR must be the values the bios reports. 


