Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262853AbREVWB6>; Tue, 22 May 2001 18:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbREVWBs>; Tue, 22 May 2001 18:01:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:51460 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S262853AbREVWBj>; Tue, 22 May 2001 18:01:39 -0400
Message-ID: <3B0AE188.C5457975@evision-ventures.com>
Date: Wed, 23 May 2001 00:00:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105222135.XAA78936.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> Martin Dalecki writes:
> 
> > I fully agree with you.
> 
> Good.
> 
> Unfortunately I do not fully agree with you.
> 
> > Most of the places where there kernel is passing kdev_t
> > would be entierly satisfied with only the knowlendge of
> > the minor number.
> 
> My kdev_t is a pointer to a structure with device data
> and device operations. Among the operations a routine
> that produces a name. Among the data, in the case of a
> block device, the size, and the sectorsize, ..
> 
> A minor gives no name, and no data.
> 
> Linus' minor is 20-bit if I recall correctly.
> My minor is 32-bit. Neither of the two can be
> used to index arrays.

Erm... I wasn't talking about the DESIRED state of affairs!
I was talking about the CURRENT state of affairs. OK?
The fact still remains that most of the places which a have pointed
out just need the minor nibble of whatever bits you pass to them.

Apparently nobody on this list here blabbering about a new improved
minor/major space didn't actually take the time and looked into
all those places where the kernel is CURRENTLY replying in minor/major
array enumeration. They are TON's of them. The most ugly are RAID
drivers
an all those MD LVW and whatever stuff as well as abused minor number
spaces as replacements of differnt majors.

At least you have admitted that you where the one responsible for
the design of this MESS.
