Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbTBNW6O>; Fri, 14 Feb 2003 17:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTBNW6N>; Fri, 14 Feb 2003 17:58:13 -0500
Received: from ppp-62-245-161-109.mnet-online.de ([62.245.161.109]:48004 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id <S267505AbTBNW6N>; Fri, 14 Feb 2003 17:58:13 -0500
Date: Sat, 15 Feb 2003 00:08:50 +0100
To: linux-kernel@vger.kernel.org
Subject: why does it *not* crash?
Message-ID: <20030214230850.GC1073@frodo.midearth.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: frodo@dereference.de (Julien Oster)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I'm trying to understand memory management on IA-32. I already read a
lot, and also coded a lot in assembler to test some things out.

However, one thing, I just don't understand and I can't seem to find a
hint how it works.

Wenn I write a very small kernel module, which just sets ESP to
0x00000000, shouldn't the processor shut down and the mainboard reset?
But no: it causes an oops, kills the process where the error originated from
(in this case insmod, since it was loading the module) and happily
continues working as if nothing ever happened.

But how can this work? I know there are special fields in the TSS which
specify what to load ESP with in case of a privilege transition, but
there is no privilege transition since I'm already in CPL 0, or is
there?

Even the IA-32 developer's manual says, that giving ESP a value of 0 in
CPL 0 should shut down the processer, since there's no stack for
anything anymore.

So, what's the magic in Linux? :)

Thanks in advance,
Julien

