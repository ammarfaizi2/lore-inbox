Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTIMHl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 03:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTIMHl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 03:41:27 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:26303 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262070AbTIMHl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 03:41:26 -0400
Message-ID: <3F62CA41.3040900@sbcglobal.net>
Date: Sat, 13 Sep 2003 02:41:53 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart Longland <stuartl@longlandclan.hopto.org>
CC: iain d broadfoot <ibroadfo@cis.strath.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: getting a working CD-drive in 2.6
References: <20030912093837.GC2921@iain-vaio-fx405> <3F627C13.6020608@longlandclan.hopto.org> <3F628811.1010209@sbcglobal.net> <1063436241.3f62bfd163b32@www.longlandclan.hopto.org>
In-Reply-To: <1063436241.3f62bfd163b32@www.longlandclan.hopto.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stuart Longland wrote:

>Quoting Wes Janzen <superchkn@sbcglobal.net>:
>
>  
>
>>Hi,
>>
>>Actually with 2.6, you no longer need ide-scsi.  You'll need to upgrade 
>>your cdrecord tools and probably your burning GUI, if you use one....
>>
>>    
>>
>
>Ahh okay, I wasn't aware of that.  We use a SCSI burner anyways, but most of my...
>
>  
>
And here's an even better reason to avoid ide-scsi in 2.6 (Jens sent 
this to the list, but I don't see it...):

>Jens Axboe wrote:
>
>
>  
>That's because it _is_ faster. It contains no silly memory allocations
>for the buffer and data copying in the kernel, the data is mapped from
>the user buffer and DMA'ed directly from there. It also uses DMA where
>ide-scsi wont.
>
>People generally report that they have no problems burning at full speed
>(52) on even really old machines where ide-scsi maxed out long before.
>
>  
>
Certainly that is true.  The system was nearly unresponsive at 16X (on 
2.4.18 SuSE) with my K6-2 400, but I can set it up to 32X now and I have 
no problems.  My recorder never hits 32X with my media though, maxes out 
at around 20X but I can browse the web while burning with absolutely no 
fear of my buffer running dry (probably helps that it's a 8MB buffer but 
cdrecord still never reports it being low).  That's a big change from 2.4.

-Wes Janzen-

