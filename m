Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUAYXUm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUAYXUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:20:42 -0500
Received: from auemail2.lucent.com ([192.11.223.163]:11943 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265277AbUAYXUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:20:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.20183.783477.596431@gargle.gargle.HOWL>
Date: Sun, 25 Jan 2004 18:18:47 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: John Stoffel <stoffel@lucent.com>, Andi Kleen <ak@muc.de>,
       Valdis.Kletnieks@vt.edu, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
In-Reply-To: <20040125214920.GP513@fs.tum.de>
References: <200401251639.56799.cova@ferrara.linux.it>
	<20040125162122.GJ513@fs.tum.de>
	<200401251811.27890.cova@ferrara.linux.it>
	<20040125173048.GL513@fs.tum.de>
	<20040125174837.GB16962@colin2.muc.de>
	<200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
	<20040125191232.GC16962@colin2.muc.de>
	<16404.9520.764788.21497@gargle.gargle.HOWL>
	<20040125202557.GD16962@colin2.muc.de>
	<16404.10496.50601.268391@gargle.gargle.HOWL>
	<20040125214920.GP513@fs.tum.de>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian> On Sun, Jan 25, 2004 at 03:37:20PM -0500, John Stoffel wrote:

>> More confirmation as I get it.

Adrian> I'd say that's a different issue: The gcc 3.3 in debian
Adrian> unstable doesn't know about -funit-at-a-time, and it should
Adrian> therefore not be affected by this problem.

It certainly didn't seem to make a difference, after doing a make
mrproper and then putting my .config back in place, it still doesn't
boot.  I'm not doing anything funky in grub, here's my boot options:

    title           2.6.2-rc1-mm3
    root            (hd0,0)
    kernel          /vmlinuz-2.6.2-rc1-mm3 root=/dev/sda2 ro
    savedefault
    boot

I point this out since the last Oops I got on boot said something
about kernel_options, but since I didn't write it down, that's not a
good report.

I'll see about falling back to 2.6.1-mm5 and then to 2.6.2-rc1 and
seeing what happens.  I could even try going back to 2.6.1 plain as
well.  

Any suggestions?  Or any other info I can provide here?

John


