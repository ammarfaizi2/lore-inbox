Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbRHHSzV>; Wed, 8 Aug 2001 14:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbRHHSzM>; Wed, 8 Aug 2001 14:55:12 -0400
Received: from mta1n.bluewin.ch ([195.186.1.210]:14760 "EHLO mta1n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S266559AbRHHSzA>;
	Wed, 8 Aug 2001 14:55:00 -0400
Message-ID: <3B6E44EE000F26DC@mta1n.bluewin.ch> (added by postmaster@bluewin.ch)
From: "Per Jessen" <per@computer.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mark H. Wood" <mwood@IUPUI.Edu>
Date: Wed, 08 Aug 2001 21:03:14 +0200
Reply-To: "Per Jessen" <per@computer.org>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: how to tell Linux *not* to share IRQs ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001 12:13:40 -0500 (EST), Mark H. Wood wrote:

>On Wed, 8 Aug 2001, Andrew McNamara wrote:
>[snippage]
>> The problem is largely historical - each interrupt traditionally had a
>> physically line associated with it, and lines on your backplane were a
>> limited resource.
>>
>> If you were to do it again these days, you might have some sort of
>> shared serial bus, so devices could give detailed data to the cpu
>> (not only to uniquely identify the interrupting device, but also
>> identify sub-devices - say a USB peripheral).
>
>See for example "vectored interrupts" on the PDP10.  The device driver
>tells the device where the driver's ISR is, and when the device
>interrupts, it puts that address on the bus.  The interrupt logic jumps
>directly to the ISR, which "knows" it is the only driver that would be
>interested in this interrupt.  (You could set up a jump table if you
>wanted to, so that each device of the same type could identify itself
>uniquely, but that typically wasn't a big problem in '10 installations
>where multiples were most likely in a PDP11 on the other side of a DTE20,
>or Massbus devices on a single RH20.)
>
>Apparently this idea is now so old that it is new. :-)

Yeah - I believe the same was possible on the Z80 - though I'd have to 
go read the manual to be certain.


regards,
Per Jessen, Zurich

Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."




regards,
Per Jessen, Zurich
http://www.enidan.com - home of the J1 serial console.

Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."


