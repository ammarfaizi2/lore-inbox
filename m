Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbTAVEi5>; Tue, 21 Jan 2003 23:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTAVEi5>; Tue, 21 Jan 2003 23:38:57 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:2313 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267312AbTAVEi4>; Tue, 21 Jan 2003 23:38:56 -0500
Message-ID: <3E2E2258.8030908@snapgear.com>
Date: Wed, 22 Jan 2003 14:47:20 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
References: <Pine.LNX.4.44.0301212045000.1577-100000@chaos.physics.uiowa.edu>	<3E2E0F38.7090506@snapgear.com> <buoptqp954l.fsf@mcspd15.ucom.lsi.nec.co.jp>
In-Reply-To: <buoptqp954l.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya Miles,

Miles Bader wrote:
> Yeah, the new generic RODATA stuff is way broken on the v850 too.
> 
> Besides the over-eager use of sections, it also assumes that C symbol
> names map one-to-one with `linker symbol' names, which isn't true with
> the default v850 compiler.
> 
> Here's my local rewrite of include/asm-generic/vmlinux.lds.h, which
> works on the v850, and seems like it should be usable by other systems
> as well.
> 
> It does two things:
[snip]
> 
> What do you think of this?

I like it. Looks like an ideal solution, keeps a bunch of
stuff common, but is a lot more flexible in terms of output
sections (and their regions) .


> [To be honest, I think the stuff with `LOAD_OFFSET' is a bit of a waste;
> it seems cleaner to just have archs define their own sections as
> appropriate, and use RODATA_CONTENTS directly -- it's the input sections
> and related symbols that are always changing (and so better centralized),
> after all, not the output sections.]

Agree 100%.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

