Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277240AbRJDVaE>; Thu, 4 Oct 2001 17:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277239AbRJDV3y>; Thu, 4 Oct 2001 17:29:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277242AbRJDV3m>; Thu, 4 Oct 2001 17:29:42 -0400
Subject: Re: ftruncate
To: plars@austin.ibm.com (Paul Larson)
Date: Thu, 4 Oct 2001 22:35:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkml), torvalds@transmeta.com,
        ltp-list@lists.sourceforge.net (ltp)
In-Reply-To: <1002118765.12683.8.camel@plars.austin.ibm.com> from "Paul Larson" at Oct 03, 2001 02:19:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pG9G-0004Jh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that it does NOT pass on 2.4.10-ac4.  It looks like the problem is with
> 2.4.11-pre1 and the testcase though if my man pages are right.  The test
> is looking to get EACCESS back when the file is opened read only and
> ftruncate is called on it, but the man page says it should actually
> return EINVAL.
> 
> A fixed version of this testcase will be in our next release.  I know
> it's fairly trivial, but it would be nice to see this fix synced up with
> Linus's tree.

There are about 10 standards violations in the Linus tree against file
truncation behaviour (things like ftruncate > 2Gb without 64bit etc).
Merging them with the current scale of the fs/block changes in the current
Linus tree and their rate of change isnt feasible
