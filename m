Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUATTE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbUATTE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:04:57 -0500
Received: from mail.tmr.com ([216.238.38.203]:17928 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265693AbUATTE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:04:56 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] fix for ide-scsi crash
Date: 20 Jan 2004 19:04:47 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <buju4f$53t$1@gatekeeper.tmr.com>
References: <1g4Ao-60b-25@gated-at.bofh.it> <E1AixLR-0000Hh-00@neptune.local>
X-Trace: gatekeeper.tmr.com 1074625487 5245 192.168.12.62 (20 Jan 2004 19:04:47 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E1AixLR-0000Hh-00@neptune.local>,
Pascal Schmidt  <der.eremit@email.de> wrote:
| On Tue, 20 Jan 2004 15:00:16 +0100, you wrote in linux.kernel:
| 
| >> I'd really like the ATA cdrom driver to handle different sector sizes 
| >> properly. There really is no excuse for a block device driver to hardcode 
| >> its blocksize if it can avoid it.
| > 
| > Agree, it's a bug. Pascal, care to take a stab at fixing it? You're the
| > most avid ide-cd non-2kb block size user at the moment :)
| 
| There's a lot of macros related to sector sizes in ide-cd.h. I suppose
| all that would need to be changed to depend on the real hardware sector
| size?
| 
| I don't have any idea about block layer internals or about sending
| commands to a drive.
| 
| In fact, I don't even know how to start or what uses of sector size
| in ide-cd.c really need to be changed. Much less do I know where
| information about hardware sector size could be gotten and how it should
| be stored for use by ide-cd.

To pour confusion on this, I thought this was working already. I just
(Sunday) tried burning audio CDs with the ide-cd interface, using
Joerg's new a25 version of cdrecord which claimed to use DMA for 2352
byte audio sectors. Worked! About 92% idle and 5% wait-io. only 1%
system while burning at 32x. And the CD does play just fine, I listened
to it all the way to work.

Is this a physical/logical sector thing, or is Joerg doing a magic
trick, or what? Definitely does work in terms of producing correct
output, is it really writing 2352 byte secotrs?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
