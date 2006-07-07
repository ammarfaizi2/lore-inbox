Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWGGRlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWGGRlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWGGRlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:41:08 -0400
Received: from khc.piap.pl ([195.187.100.11]:11156 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932234AbWGGRlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:41:07 -0400
To: Valdis.Kletnieks@vt.edu
Cc: ric@emc.com, Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	<20060701170729.GB8763@irc.pl>
	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	<20060701181702.GC8763@irc.pl> <44AD286F.3030507@emc.com>
	<m3ejwyiryr.fsf@defiant.localdomain> <44AD4807.6090704@emc.com>
	<200607062052.k66KqMDH027923@turing-police.cc.vt.edu>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 07 Jul 2006 19:41:05 +0200
In-Reply-To: <200607062052.k66KqMDH027923@turing-police.cc.vt.edu> (Valdis Kletnieks's message of "Thu, 06 Jul 2006 16:52:22 -0400")
Message-ID: <m3d5ch8g9a.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> Backup programs want it stored with the file.

Not necessarily - backup may want to store the hashes in some central
place as well. I'm using such solution and it has only positives.

> If the filesystem stored a "guaranteed trustable current hash", Tripwire
> *could* use it to compare against its database rather than having to re-read
> the file and recompute it.  Unfortunately, a useful trustable hash is
> basically incompatible with any sort of incremental updating (except for
> the special case of appending to the file).

Block hashes + master hash could allow something like that. Not sure
if we want it in the fs, though.
-- 
Krzysztof Halasa
