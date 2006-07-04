Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWGDLTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWGDLTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWGDLTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:19:18 -0400
Received: from khc.piap.pl ([195.187.100.11]:34528 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751283AbWGDLTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:19:18 -0400
To: Neil Brown <neilb@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	<20060701170729.GB8763@irc.pl>
	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	<20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	<20060703205523.GA17122@irc.pl>
	<1151960503.3108.55.camel@laptopd505.fenrus.org>
	<1151964720.16528.22.camel@localhost.localdomain>
	<17577.43190.724583.146845@cse.unsw.edu.au>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 04 Jul 2006 13:19:11 +0200
In-Reply-To: <17577.43190.724583.146845@cse.unsw.edu.au> (Neil Brown's message of "Tue, 4 Jul 2006 09:31:02 +1000")
Message-ID: <m3psglhb2o.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> writes:

> With checksums - the filesystem is in a better position to:
>  - be selective about what is checksummed - no point checksumming
>    blocks that aren't part of any file.  Some blocks (highlevel
>    metadata) might always be checksummed, while other blocks
>    (regular data) might not if a 'fast' option was chosen.

The same applies to RAID - for example, why "synchronise" unused area?

While fs vs. RAID provides a good layering scheme and is easier,
integrating them into one entity (as with ZFS) would certainly be
more efficient (and probably harder to maintain).
-- 
Krzysztof Halasa
