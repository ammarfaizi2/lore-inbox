Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSC0X6o>; Wed, 27 Mar 2002 18:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310483AbSC0X6e>; Wed, 27 Mar 2002 18:58:34 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:4870 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310224AbSC0X6U>; Wed, 27 Mar 2002 18:58:20 -0500
Date: Wed, 27 Mar 2002 15:57:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jos Hulzink <josh@stack.nl>
cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <20020327235029.P78593-100000@snail.stack.nl>
Message-ID: <Pine.LNX.4.10.10203271553520.6006-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Jos Hulzink wrote:
> 
> Hi, here your EE :)
> 
> IDE indeed never was ment to be hot pluggable. With SCSI, you can tell a
> hard disk to shut down and disconnect from the bus. With IDE, your
> controller has to shut down completely. You can tell your disk to
> spin down, but in any case, your disk will remain powered. In shutdown
> mode, your disk will not consume much power anymore, but the electronics
> are NOT in a "feel free to disconnect now" state. The disk is still
> listening to the bus.
> 
> This means that unplugging one device can have undetermined results for
> both that device and the complementary device on the bus. As an EE, I must
> admit the chances are VERY, VERY odd that it will actually affect data,
> but personally, I'm one of those guys who say: In theory, it's possible,
> so this is a "don't".
> 
> There are controllers who say they can shut down completely, but I have
> never seen an IDE disk which can do it. The fact you can bring any disk
> back alive after a sleep command (part of the latest ATA standards), means
> the disk isn't suitable for hot-swapping.
> 
> If you really want to build in IDE hot swap support, I demand it comes
> with a warning: Enabling this option will probably destroy your harddisks
> and your chipset. Feel free to continue, but don't blame us.

FYI, there was almost a witch hunt when I went into T13 with a SCA4ATA
proposal.  You understand the issue and I am glad it was you and not me to
have to bang this drum.  Thanks.

> > Disclaimer: I am not an Electronics Engineer, nor an expert
> > on IDE/ATA/ATAPI yadda, yadda, yadda.  I wrote because this
> > thread, while useful for the future  was on a tangent that
> > wasn't telling John Summerfield how he might actually do
> > what he wants, today.
> 
> Disclaimer: I am an EE, well known with IDE/ATA. I wrote this because my
> opinion is Linus should block any attempts of hot pluggable IDE devices,
> for Linux will be the only OS that supports it and destroys your harddisks
> thanks to the fact it supports it (If other OSes support it, please let
> me know, I'll guarantee you there are lots of warnings involved). Hot
> plugging might work, when you are lucky. Luck is not something that should
> be the base of a decent OS. If hot IDE plugging makes its way in, don't
> blame me...

Yep and I have melted a pile of silicon on mistakes.
I have about 500GB in drives that are paper weights.
The difference is I could use a few extra bricks as book ends.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

