Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbTCFXNv>; Thu, 6 Mar 2003 18:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbTCFXNu>; Thu, 6 Mar 2003 18:13:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261264AbTCFXNs>; Thu, 6 Mar 2003 18:13:48 -0500
Message-ID: <3E67D89B.1010308@zytor.com>
Date: Thu, 06 Mar 2003 15:24:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reserving physical memory at boot time
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com> <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net> <b442s0$pau$1@cesium.transmeta.com> <32981.4.64.238.61.1046844111.squirrel@www.osdl.org> <b453mj$qpi$1@cesium.transmeta.com> <20030306212607.GA173@elf.ucw.cz>
In-Reply-To: <20030306212607.GA173@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Really? So user has to know where ACPI tables are and specify less
> than that on mem= command line? That seems very
> counter-intuitive. [Ahha, its probaly okay because e820 saves you.]
> 
> What do you pass on 4GB machine as mem= parameter? AFAIK those beasts
> have hole at 3.75G. [Hopefully bigmem machines have working e820
> tables?]
> 

If you pass mem= you have to pass mem=3840M.  Yes, it sucks, but if you
genuinely have a machine which is so fucked up that you can't rely on
the memory map the BIOS presents to you, you have problems to begin with.

Oh yes, this is why GRUB passing the mem= parameter gratuitously was
beyond total and complete brainfuckage.

	-hpa


