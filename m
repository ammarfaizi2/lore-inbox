Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWBFHqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWBFHqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWBFHqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:46:53 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:51145 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750736AbWBFHqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:46:53 -0500
Message-ID: <43E70029.4060906@aitel.hist.no>
Date: Mon, 06 Feb 2006 08:52:09 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: Eric Piel <Eric.Piel@tremplin-utc.net>, linux-kernel@vger.kernel.org
Subject: Re: [OT] How to tune kernel to swap more often (video ram swap)
References: <b92f4fd10602050204g41f70f70p@mail.gmail.com> <43E5DD0A.3030009@tremplin-utc.net> <20060205111752.GA4636@irc.pl>
In-Reply-To: <20060205111752.GA4636@irc.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:

>On Sun, Feb 05, 2006 at 12:10:02PM +0100, Eric Piel wrote:
>  
>
>>05.02.2006 11:04, Paweł Zadrąg wrote/a écrit:
>>    
>>
>>>Yo...
>>>
>>>In normal case, using harddisk as a swap space i should ask how to cut
>>>down swapping, or make swapping when idle, etc... My case is a little
>>>bit diffrent... I have a 256MB video card, while 240MB of it is used
>>>as a swap space. And the question is: how to tune kernel to swap more
>>>often. I known swapped memory must be copied back to ram before beeing
>>>used, so i'm looking for a reasonable tunning values...
>>>      
>>>
>>Am I correctly understanding that you are using your video card memory 
>>as a place to put swap? This sounds quite cool, how have you done this? 
>>Is there a driver which can report the video ram as a block device?
>>    
>>
>
> It's an old trick with MTD devices:
>http://hedera.linuxnews.pl/_news/2002/09/03/_long/1445.html
>  
>
Nice trick.  If you also have swapspace on disk, remember to
give the "mtd swap" higher priority in /etc/fstab.
That way, disk swapping will only happen when the mtd swap is full.

Helge Hafting
