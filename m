Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267685AbTA1RwA>; Tue, 28 Jan 2003 12:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267680AbTA1RwA>; Tue, 28 Jan 2003 12:52:00 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:44280 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S267685AbTA1Rv7>; Tue, 28 Jan 2003 12:51:59 -0500
Message-ID: <3E36C2A3.4080102@mvista.com>
Date: Tue, 28 Jan 2003 10:49:23 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: New model for managing dev_t's for partitionable block devices
References: <3F61ABC3.1080502@tin.it>            <3E36BBDF.4090104@mvista.com> <200301281746.h0SHkOgM007373@turing-police.cc.vt.edu>
In-Reply-To: <200301281746.h0SHkOgM007373@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For newer revs of linux, I was specifically thinking of implementing 
using device mapper to provide partition mapping so your thinking just 
like me :)  The only downside is device mapper becomes a required 
component instead of being module capable since partition information is 
needed before early boot is available to load modules.

Regards,
-steve

Valdis.Kletnieks@vt.edu wrote:

>On Tue, 28 Jan 2003 10:20:31 MST, Steven Dake <sdake@mvista.com>  said:
>
>  
>
>>Each physical disk would be assigned a minor number in a group of 
>>majors.  So assume a major was chosen of 150, 151, 152, 153, there would 
>>be a total of 1024 physical disks that could be mapped.  Then the device 
>>mapper code could be used to provide partition devices in another 
>>major/group of majors.
>>    
>>
>
>This sounds suspiciously like the already-existing device mapper stuff
>used by LVM2.  Maybe all that's needed is to add a hook to add a device
>mapper entry for each partition?
>  
>

