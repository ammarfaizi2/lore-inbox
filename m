Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129395AbRBBE6z>; Thu, 1 Feb 2001 23:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129630AbRBBE6p>; Thu, 1 Feb 2001 23:58:45 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:13060 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129395AbRBBE6a>; Thu, 1 Feb 2001 23:58:30 -0500
Message-ID: <3A7A3E14.1010300@redhat.com>
Date: Thu, 01 Feb 2001 22:56:52 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Belits <abelits@phobos.illtel.denver.co.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial device with very large buffer
In-Reply-To: <Pine.LNX.4.10.10102011546290.948-100000@mercury>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex!

	I'm a little confused here... why are we overrunning? This thing is 
running externally at 19200 at best, even if it does all come in as a 
packet. I would think the flip buffer would never contain more than a 
few characters. Are you running it at a higher rate internally? Does it 
buffer up a whole packet if you do this?

Wouldn't it be a little easier to drop somthing like "AT#MRU=500\r" to 
the modem than to change the tty driver?

-- 
Joe

Alex Belits wrote:

> On Thu, 1 Feb 2001, Alan Cox wrote:
> 
> 
>>>   I also propose to increase the size of flip buffer to 640 bytes (so the
>>> flipping won't occur every time in the middle of the full buffer), however
>>> I understand that it's a rather drastic change for such a simple goal, and
>>> not everyone will agree that it's worth the trouble:
>> 
>> Going to a 1K flip buffer would make sense IMHO for high speed devices too
> 
> 
> 1K flip buffer makes the tty_struct exceed 4096 bytes, and I don't think,
> it's a good idea to change the allocation mechanism for it.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
