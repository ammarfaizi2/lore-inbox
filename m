Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286403AbSAAXwv>; Tue, 1 Jan 2002 18:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSAAXwm>; Tue, 1 Jan 2002 18:52:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58884 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286395AbSAAXwb>; Tue, 1 Jan 2002 18:52:31 -0500
Message-ID: <3C32487C.4040006@zytor.com>
Date: Tue, 01 Jan 2002 15:38:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: robert@schwebel.de
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, rkaiser@sysgo.de
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201020006240.3056-100000@callisto.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:

> 
> ----------8<----------
> Alternate Gate A20 Control Register (Port 00EEh) A special 8-bit
> read/write control register provides a fast and reliable way to control
> the CPU A20 signal.  A dummy read of this register returns a value of FFh
> and forces the CPU A20 to propagate to the core logic, while a dummy write
> to this register will cause the CPU A20 signal to be forced Low as long as
> no other A20 gate control sources are forcing the CPU A20 signal to
> propagate.
> ---------->8----------
> 
> But neither this nor the register description ("Alternate GateA20 Control
> This register can be used to cause the same type of masking of the CPU A20
> signal that was historically performed by an external SCP (System Control
> Processor) in a PC/AT Compatible system, but much faster.") says something
> about _how_ fast it is done.
> 


Right, so you need the explicit synchronization.

Do you happen to know if there is an easy and safe way to detect an Elan 
at runtime?  If so, it might make more sense to make this a runtime 
decision instead.

> 
> Hmm, there is no special section for chipset issues, the only ones I could
> find are "Toshiba Laptop support" and "Dell Laptop Support" (also in
> "Processor type and features"). Other chipset bugfix options are in the
> IDE driver section, but this doesn't apply here. So the options would be
> 
> - add something like "Elan Support" in "Processor type and features"
> - add a new section for general chipset fixes
> 
> What do you think?
> 


"Processor type and features" is good enough for now, I think.  It's not 
a very large section.

	-hpa

