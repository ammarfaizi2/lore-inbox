Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264906AbUD2RSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbUD2RSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 13:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUD2RSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 13:18:34 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:5386 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264905AbUD2RS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 13:18:28 -0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Timothy Miller <miller@techsource.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1083258760@astro.swin.edu.au>
Subject: Re:  File system compression, not at the block layer
In-reply-to: <20040429095237.GC390@elf.ucw.cz>
References: <408951CE.3080908@techsource.com> <c6bjrd_pms_1@news.cistron.nl> <20040423174146.GB5977@thunk.org> <20040427203426.GB6116@openzaurus.ucw.cz> <409036C4.7030102@techsource.com> <20040429094644.GA6098@wohnheim.fh-wedel.de> <20040429095237.GC390@elf.ucw.cz>
X-Face: "0\RuOFb6AcQ}B_F/^%;;AmS%><zZ_q?N1w1%1voDY7#Ywj~qRaL7].8HB'2~pDUS|{E=$R\-s?;+p!RCe:w||kS\T@[(eQHB*-8u;~)ZP4;QYUI`|GJ)NS\`jLbW<e'R*y+Od,S5D+Vz++a<[$g'>"qr*^0t%eriBMe_x]B7&@b8_\i<A/A@T
Message-ID: <slrn-0.9.7.4-1869-21678-200404300312-tc@hexane.ssi.swin.edu.au>
Date: Fri, 30 Apr 2004 03:17:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> said on Thu, 29 Apr 2004 11:52:37 +0200:
> Hi!
> 
> > > I've always felt that way, but every time I mention it, people tell me 
> > > it's not worth the CPU overhead.  For many years, I have felt that there 
> > > should be an IP socket type which was inherently compressed.
> > 
> > Ever heard of ssh? ;)
> 
> Its too high level, and if you want compression but not encryption
> that's tricky to do.

Just today we were trying to transfer ~350GB from a shell of a machine
(running knopix, with a very small amount of installed software, and
absolutely no disk space left) holding 4 disks to our raid disks --
the only thing installed was ssh, with even rsh being a symlink to ssh
(I was going to remove a whole bunch of packages to free up some space
so I could install rsh, but they didn't let me - it took them long
enough to get it to "work" in the first place).

Problem was that rsync combined with ssh was reading/writing at about
2MB/sec, given the age of the CPU. That will take a day more than
they have.

To put it bluntly, ssh is a *shit* solution on a secured net where
people care about performance.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
White dwarf seeks red giant star for binary relationship
