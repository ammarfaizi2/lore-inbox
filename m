Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313724AbSDPPub>; Tue, 16 Apr 2002 11:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313722AbSDPPu3>; Tue, 16 Apr 2002 11:50:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4112 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313724AbSDPPtb>; Tue, 16 Apr 2002 11:49:31 -0400
Date: Tue, 16 Apr 2002 08:46:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        David Lang <david.lang@digitalinsight.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <20020416172434.A1180@ucw.cz>
Message-ID: <Pine.LNX.4.33.0204160844090.1167-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Apr 2002, Vojtech Pavlik wrote:
> 
> Note that the above commands are no help in case of plugging TIVO
> drive into a PC. While they assure that all ext2 filesystems are LE on
> the media and all sun disklabels are BE on the media, still if you plug
> in a BE ext2 into the system (or a BE PC partition table), the kernel
> won't understand them.

Please use a the network block device, and teach the ndb deamon to just 
byteswap each word.

Problem solved, WITHOUT keeping bugs in the IDE driver.

Oh, and performance improved at the same time.

What are you guys thinging about? There are two rules here:
 - optimize for the common case
 - keep the code clean.

Both of them say that Martin is 100% right.

		Linus

