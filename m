Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754173AbWKMHYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbWKMHYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 02:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbWKMHYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 02:24:40 -0500
Received: from poczta1.linux.webserwer.pl ([193.178.241.18]:16587 "EHLO
	poczta1.linux.webserwer.pl") by vger.kernel.org with ESMTP
	id S1754173AbWKMHYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 02:24:40 -0500
Message-ID: <45581DB0.6030609@limcore.pl>
Date: Mon, 13 Nov 2006 08:24:32 +0100
From: "lkml-2006i-ticket@limcore.pl" <lkml-2006i-ticket@limcore.pl>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with file systems created on 2.6.18.x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, on two different boxes with 2.6.18.x kernels I created two file
systems (ReiserFS and JFS). Both failed totally after about 1-2 days of
using them.

Dmesg reported corruption errors/warnings. When I unmounted and tried to
remount - mound was unable to find superblocks.

Fsck for JFS was hopeless.

Fsck for ReiserFS had to recreate superblocks, journal and rebuild tree
(I am doing that now).

So both FS where very badly corrupted.

On both boxes I have other HDs with multiple filesystems (including JFS
and reiserfs) and all is working fine for over year (including long time
for 2.6.18 line).

Before both failures I was playing with swap (swapoff -a swapon -a), I
use encripted swap.

The "old" partitions seem to be 100% ok all the time. It probably is not
 a hardware problem (I runned some low-level tests).

So, perhaps there is a bug connected to some of the following aspects:
- using newly or recently created file system (bug in code that is used
to grow a short, "young" tree)
- problems with swap / encrypted swap

I saved image of 100 mb of the beginning of reiserfs partition after it
failed,  I can sent it (or part of it) if anyone wants to investigate.

Since I use grsecurity patch -
http://forums.grsecurity.net/viewtopic.php?p=6355#6355

-- 
LimCore    C++ Software Architect / Team Lead
---> oo    Linux programs
limcore
software


