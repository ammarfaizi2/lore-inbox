Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313267AbSDJP5D>; Wed, 10 Apr 2002 11:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313264AbSDJP5C>; Wed, 10 Apr 2002 11:57:02 -0400
Received: from winds.org ([209.115.81.9]:55812 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S313261AbSDJP5A>;
	Wed, 10 Apr 2002 11:57:00 -0400
Date: Wed, 10 Apr 2002 11:53:15 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
cc: "'davidsen@tmr.com'" <davidsen@tmr.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Using video memory as system memory
In-Reply-To: <61DB42B180EAB34E9D28346C11535A78177E34@nocmail101.ma.tmpw.net>
Message-ID: <Pine.LNX.4.44.0204101146050.13516-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Holzrichter, Bruce wrote:

> I thought that this was interesting as well, and had a couple of questions,
> as I am no expert in this stuff.
> 
> You don't have the frame buffer enabled for display when trying to use this
> as system memory, correct?

Correct. :) In fact, text mode can only take a maximum of the first 256KB of
memory of the card (extended text paging). So as long as you only target the
rest of the memory (and don't use X or svgalib) you should be fine.

> Are there implications of the BIOS shadowing video memory to system memory,
> or is that not an issue once Linux takes over memory control?

Not that I'm aware of. This is PCI-mapped prefetchable memory.

> That is a neat idea, though.  The PCI/AGP bus may be a limiting factor for
> this as well, correct?  As far as speed, I believe most video cards have
> fast memory, vram, or sram, but it's only useful transferring between the
> Video GPU, and Video cards memory, as the bus to the video card is the
> bottleneck.

Yeah. In fact in some responses the 'slow speed' consideration was so much that
they all say I'd be better off writing a block driver and making use of the
memory more as a swap device rather than as system RAM.

Has anyone out there done this yet? I figure I'd ask before reinventing
anything.. :)

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

