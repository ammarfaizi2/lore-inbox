Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbTDAMct>; Tue, 1 Apr 2003 07:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTDAMct>; Tue, 1 Apr 2003 07:32:49 -0500
Received: from platane.lps.ens.fr ([129.199.121.28]:15750 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP
	id <S262482AbTDAMcs>; Tue, 1 Apr 2003 07:32:48 -0500
Date: Tue, 1 Apr 2003 14:44:04 +0200
From: Eric Brunet <ebrunet@lps.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: 845GE Chipset severe performance problems
Message-ID: <20030401124404.GA26931@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1049039985.14686.11.camel@dhcp22.swansea.linux.org.uk>
References: <188481168784.20030329130300@btinternet.com> <1048949147.6725.3.camel@dhcp22.swansea.linux.org.uk> <153495685337.20030329170457@btinternet.com> <1049039985.14686.11.camel@dhcp22.swansea.linux.org.uk>


As there is this thread about mtrr on Intel chipsets, I have some
messages in the log about mtrr, and I don't know whether they are
harmless warnings or errors that should be reported.

My computer is a 2.4 GhZ Pentium IV with an intel i845G/GL chipset.
Motherboard and bios by shuttle.

$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x1f800000 ( 504MB), size=   8MB: uncachable, count=1
reg02: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=2

I have 512 MB of memory, the motherboard doesn't support more than 2GB
and I don't see what is this range over 3.5 GB. Also, the two first
overlaping ranges look suspicious.

I have the following error/warning messages in the log:

* with kernel 2.4.21pre3 (+ acpi patches)
        mtrr: base(0xe0020000) is not aligned on a size(0x800000)
boundary
  (this happens just after initializing drm)

* with kernel 2.5.63 (+ acpi patches)
        mtrr: MTRR 2 not used
  (this happens once or twice during each sutdown. Note that I don't have
  drm with kernel 2.5.x, so I don't know if the first message is really
gone)

So... Is this situation normal ?

Éric Brunet
