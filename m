Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWGIJuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWGIJuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 05:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGIJuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 05:50:46 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:61656 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751322AbWGIJuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 05:50:46 -0400
Date: Sun, 9 Jul 2006 11:50:12 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: 7eggert@gmx.de, Bill Davidsen <davidsen@tmr.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
In-Reply-To: <1152283049.5726.26.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0607091141450.2600@be1.lrz>
References: <6tVcC-1e1-79@gated-at.bofh.it> <6uXYv-3RG-1@gated-at.bofh.it> 
 <6veG8-350-7@gated-at.bofh.it> <6vfiU-465-13@gated-at.bofh.it> 
 <6vmNk-77r-23@gated-at.bofh.it> <6vnq7-7Tw-55@gated-at.bofh.it> 
 <6vrN0-5Se-9@gated-at.bofh.it> <6vBsY-38p-9@gated-at.bofh.it> 
 <E1Fymn1-0000g6-7s@be1.lrz> <1152283049.5726.26.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Trond Myklebust wrote:
> On Fri, 2006-07-07 at 11:38 +0200, Bodo Eggert wrote:

> > If the changes to these files are very infrequent compared to nanoseconds,
> > you'll only need the version during some nanoseconds, and only during
> > runtime. Having a second-change-within-one-timeframe-flag(*) instead of
> > versions will be enough to make NFS mostly happy and only penalize your
> > users for one nanosecond, and it won't force version-keeping into the
> > filesystem. And besides that, all other filesystems will profit even
> > without having nanosecond resolution nor versioning (but they'll suffer
> > for up to a whole second).
> 
> NFS never required file versioning. You're talking to the wrong person.
> It does, however, need a change attribute that logs all changes to the
> file. The above flag does not suffice to provide that.

ACK, that's why I'm suggesting this doublechange-flag.
-- 
In the beginning, God created the earth and rested.
Then God created Man and rested.
Then God created Woman.
Since then, neither God nor Man has rested.
