Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbTH2Qa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbTH2Qa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:30:27 -0400
Received: from tmi.comex.ru ([217.10.33.92]:29077 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261465AbTH2Q2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:28:36 -0400
X-Comment-To: Ed Sweetman
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Fri, 29 Aug 2003 20:34:01 +0400
In-Reply-To: <3F4F7D56.9040107@wmich.edu> (Ed Sweetman's message of "Fri, 29
 Aug 2003 12:20:38 -0400")
Message-ID: <m3isogpgna.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>
	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>
	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
	<m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ed Sweetman (ES) writes:

 ES> I was testing this with only a single partition mounted with extents
 ES> enabled when benchmarking.  Ext3 gave no messages of being mounted
 ES> afterbootup with or without extents so to make sure i had extents
 ES> enabled i booted with all my partitions with the extents option.  I
 ES> suspect then my problems began.  I'm completely unaware of the extent
 ES> of the damage enabling extents has done since most of the important
 ES> things were opened, not created during my extents use.  In any case it
 ES> may be that the reason why init is not able to be found is because i
 ES> used apt and upgraded my system ...and I dont remember if i had
 ES> extents enabled at the time or not.  If my init is in extents format
 ES> though, then why is a patched kernel able to read it with extents not
 ES> being enabled via the omunt option where as kernels without the patch
 ES> cannot.  Is extents able to be read from a fs even when it's not
 ES> mounted with the option but not written?   I'm kinda confused, this
 ES> aspect of extents wasn't in the original email.

well, on my testbox I use _patched with extents_ ext3 as / and /boot partitions.
I haven't seen any problems on them. with patch, ext3 look at special EXTENTS
flag in inode (this flag is set up only for newly created files on fs being
mounted with extents enabled) and calls apropriate routines. thus, it will
call extents routines for those file even if fs is being mounted with extents
disabled. I really do believe that your root filesystem haven't been mounted
with extents enabled, so init must be stored in good old format.

 ES> i'm going to try and boot a kernel without the extents patch (so far
 ES> hasn't been possible) and run dbench again and see if i get different
 ES> numbers.  I'm almost suspecting extents being enabled no matter what i
 ES> mount the fs's as.

that would be fine!




