Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUAGT3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUAGT1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:27:24 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:1032 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S266216AbUAGT0q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:26:46 -0500
Message-ID: <3FFC5E81.60108@kolumbus.fi>
Date: Wed, 07 Jan 2004 21:31:13 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <3FFC5CBB.5050507@kolumbus.fi> <20040107192434.GA823@kroah.com>
In-Reply-To: <20040107192434.GA823@kroah.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 07.01.2004 21:28:52,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 07.01.2004 21:28:00,
	Serialize complete at 07.01.2004 21:28:00
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Wed, Jan 07, 2004 at 09:23:39PM +0200, Mika Penttilä wrote:
>  
>
>>Greg KH wrote:
>>    
>>
>>>On Wed, Jan 07, 2004 at 10:38:31AM -0800, Linus Torvalds wrote:
>>>      
>>>
>>>>And it really has to create _all_ of them, exactly because there's no way
>>>>to know ahead-of-time which of them will be available.
>>>>
>>>>Then, user space can just access "/dev/sda1" or whatever, and the act of 
>>>>accessing it will force the re-scan.
>>>>  
>>>>
>>>>        
>>>>
>>>Hm, that would work, but what about a user program that just polls on
>>>the device, as the rest of this thread discusses?  As removable devices
>>>are not the "norm" it would seem a bit of overkill to create 16
>>>partitions for every block device, if they need them or not.
>>>
>>>      
>>>
>>Accessing the partition would not cause the rescan (accessing the whole 
>>disk causes.) I think devfs does/did this rescan on access.
>>    
>>
>
>It would rescan on access of a partition or the main block device?
>
>If accessing the partition doesn't work, than having udev create all
>partitions wouldn't help anything :(
>
>thanks,
>
>greg k-h
>  
>

Right, rescan on access of main block device works, partition not, afaics.

--Mika


