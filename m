Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264440AbUDZHKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264440AbUDZHKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 03:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUDZHKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 03:10:11 -0400
Received: from [203.97.82.178] ([203.97.82.178]:64897 "EHLO treshna.com")
	by vger.kernel.org with ESMTP id S264440AbUDZHKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 03:10:04 -0400
Message-ID: <408CB5BA.1060301@treshna.com>
Date: Mon, 26 Apr 2004 19:09:46 +1200
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel lockup on alpha with heavy IO
References: <408C75E4.50908@treshna.com> <20040426041515.GO17014@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040426041515.GO17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Mon, Apr 26, 2004 at 02:37:24PM +1200, Dru wrote:
>  
>
>>I've recently installed debian on a alpha box and have a problem with  
>>the kernel locking up
>>after a couple of hours of heavy use.  An individual partition will stop 
>>responding, all processes
>>that try and access it will just sit there waiting and you have to 
>>reboot the server.
>>I've been using a mixture of IDE drives and they all do this. I thought 
>>it might be the motherboard
>>so i've installed a pci ide controller card, had same effect. I've tried 
>>accessing files over usb devices
>>as a finial ditch effort but it also does it there also so i am sure it 
>>is in the kernel and not
>>the hardware that is at fault.
>>    
>>
>
>... or you have problems with heat dissipation.  Get into SRM right after
>the deadlock and say show power - that should, IIRC, give you temperatures.
>  
>
Its a pretty heavy duty case with lots of cooling fans. Its very easy to
reproduce. Start up 10 cp commands on the same partition, run hdparm
-t -T /dev/sda and it will lockup within 10 seconds.  The machine is rock
solid under heavy cpu, with no io traffic. It never has kernel panic'ked
(as i would expect with temperature problems.)  If you perform more
than one write command to the same partition at the very same time,
no matter what the type drive/device it is, it locks up.

Does anyone else successfully run linux and debian testing on alpha's
with 2.6 kernels?

