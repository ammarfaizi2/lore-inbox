Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSEQLRJ>; Fri, 17 May 2002 07:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSEQLRI>; Fri, 17 May 2002 07:17:08 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57608 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315595AbSEQLRH>; Fri, 17 May 2002 07:17:07 -0400
Message-ID: <3CE4D7A7.6090704@evision-ventures.com>
Date: Fri, 17 May 2002 12:12:55 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Neil Conway <nconway.list@ukaea.org.uk>
CC: Mike Fedyk <mfedyk@matchmail.com>, vda@port.imtp.ilyichevsk.odessa.ua,
        Anton Altaparmakov <aia21@cantab.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk> <3CE22B2B.5080506@evision-ventures.com> <200205151138.g4FBcGY13110@Port.imtp.ilyichevsk.odessa.ua> <3CE24CB9.8DFC5821@ukaea.org.uk> <20020517070750.GD627@matchmail.com> <3CE4E445.3F9F57A3@ukaea.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Neil Conway napisa?:
> Mike Fedyk wrote:
> 
>>On Wed, May 15, 2002 at 12:55:37PM +0100, Neil Conway wrote:
>>
>>>You can (and must) safely "touch the cable" in between TCQ commands in
>>>the right circumstances.  You are therefore touching the cable while the
>>>hwgroup is busy, hence my suggestion that the flag we use to prevent
>>>touching the cable during DMA should be named something other than busy.
>>
>>Ahh, but with TCQ the concept of busy changes.  The wire (simplified) is
>>only busy when the tags are being transfered, otherwise the cable is unused
>>unless the cable has been "locked" by one of the devices.
> 
> 
> Hmm: "locked by one of the devices": do you mean a DMA transfer for
> example?  These are initiated by the host, but proceed asynchronously,
> so I'm not sure I'd describe it as being locked "by the device" as
> such.  At any rate, the IDE code has to remember that the cable is
> asynchronously active until DMA ends...  (Or I suppose it could just
> check the hwif BMDMA bits for the active state.)

Grep for IDE_DMA busy bits to see it - it does precisely this.


