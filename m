Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbTA3W0h>; Thu, 30 Jan 2003 17:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbTA3W0h>; Thu, 30 Jan 2003 17:26:37 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:22299
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S267498AbTA3W0g>; Thu, 30 Jan 2003 17:26:36 -0500
Message-ID: <3E39A895.9000602@rackable.com>
Date: Thu, 30 Jan 2003 14:35:01 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Wesley Wright <wewright@verizonmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB HardDisk Booting 2.4.20
References: <1043947657.7725.32.camel@steven> <1043952432.31674.22.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jan 2003 22:35:55.0846 (UTC) FILETIME=[F402EE60:01C2C8AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Thu, 2003-01-30 at 17:27, Wesley Wright wrote:
>  
>
>>My tests show that it seems to work, and I haven't noticed any odd side
>>affects by initcall-ing the usb devices (concern over this topic is why
>>I enabled it for static USB MSD only).
>>
>>Does this seem a reasonable solution, or does anyone have something more
>>elegant?
>>    
>>
>
>Is there a reason for not using initrd for this. That should let you
>use any kind of root device even ones requiring user space work before
>the real root is mounted.
>  
>

  The problem I've seen is there is a several second delay before the 
usb device is availble.  My solution was to stick a sleep in my initrd 
before attempting to mount /.  A more rational patch might be to retry 
mounting / after a few seconds delay before giving up.  I think I saw 
patch doing this on the usb list.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



