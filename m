Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTH1Siv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTH1Siv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:38:51 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:15922 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264146AbTH1Sit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:38:49 -0400
Message-ID: <3F4E4AB9.6000308@rackable.com>
Date: Thu, 28 Aug 2003 11:32:25 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stephen Hemminger <shemminger@osdl.org>,
       joe briggs <jbriggs@briggsmedia.com>
Subject: Re: binary kernel drivers re. hpt370 and redhat
References: <200308271840.30368.jbriggs@briggsmedia.com> <20030827145755.7e1ce956.shemminger@osdl.org> <3F4D4B49.8010907@rackable.com>
In-Reply-To: <3F4D4B49.8010907@rackable.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2003 18:38:47.0041 (UTC) FILETIME=[9DBB1710:01C36D93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:

> Stephen Hemminger wrote:
>
>> On Wed, 27 Aug 2003 18:40:30 -0400
>> joe briggs <jbriggs@briggsmedia.com> wrote:
>>
>>  
>>
>>> I have a client who has a raid controller currently supported under 
>>> windows, and now wants to support linux as a bootable device.  
>>> Currently, some of their trade secrets are contained in the driver 
>>> as opposed to the controller firmware, etc., so for now they wish to 
>>> release a binary-only driver to certain beta customers.  (i.e., 1st 
>>> stage of porting is similar functionality as windows). Am I correct 
>>> that in order to boot off of this device that the driver would have 
>>> to be statically linked in vs. a module which could be distributed 
>>> as a binary-only driver keyed to the kernel.revision of the 
>>> distribution's kernel?  I would like to avoid any flames and ask 
>>> that all recognize that some hardware providers are having to ease 
>>> into the pond a toe at a time.  Any constructive thoughts, 
>>> suggestions, references, tips, etc. highly appreciated.
>>>   
>>
>>
>> The driver could be a module and live in initramfs.  If you can
>> get the initial Linux image and initramfs loaded, you would be okay.
>>
>
>   Rather an initrd under Linux.

  Sorry I meant Linux 2.4. ;-)  Initramfs is a 2.6 thing.

>   Note that there is a partial source driver, and RH driver's disks 
> here: (look under raid IC with the right chipset for partial source.)
> http://www.highpoint-tech.com/usaindex.htm
>
>>
>> The problem is more in the bootloader (LILO or GRUB) would not no how
>> to do raid. The /boot partition would have to be on a non-raid 
>> partition.
>> Same problem if driver is statically linked in the kernel.
>>  
>>
>   If you are doing raid 1.  Lilo should work.  It doesn't really 
> matter if lilo isn't aware of of the data on the other drive.  Each 
> has a full copy of everything.
>
> PS-  Newer linux kernels should be able to support the "raid" 
> controller as a normal ide controller.  You could then just configure 
> linux software raid.
>


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


