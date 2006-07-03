Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWGCVB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWGCVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWGCVB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:01:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48835 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932107AbWGCVB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:01:58 -0400
Subject: Re: ext4 features
From: Arjan van de Ven <arjan@infradead.org>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060703205523.GA17122@irc.pl>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701170729.GB8763@irc.pl>
	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 23:01:43 +0200
Message-Id: <1151960503.3108.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   ZFS was already called ,,blatant layering violation''. ;)
> Yes,that what RAID is for. And if we want checksums in filesystem,
> that's the best way to utilise them.


Hi,

checksums have a very different purpose than raid.

checksums are great at detecting corruption. And yes, corruption can
happen even if you have raid, for many many reasons. Detecting means
knowing when to not trust something, when to go for the backup tapes...

raid is great for protecting against individual disks or sectors going
bad. But raid, especially high performance implementations, do not
checksum data or detect corruptions. 

They're different purpose with almost zero overlap in purpose or even
goal...

