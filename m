Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268866AbUHLXY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268866AbUHLXY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUHLXY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:24:56 -0400
Received: from zero.aec.at ([193.170.194.10]:24069 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268880AbUHLXYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:24:39 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: New concept of ext3 disk checks
References: <2ssbz-jB-1@gated-at.bofh.it> <2swyz-3ny-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 13 Aug 2004 01:24:33 +0200
In-Reply-To: <2swyz-3ny-13@gated-at.bofh.it> (Theodore Ts'o's message of
 "Fri, 13 Aug 2004 00:50:07 +0200")
Message-ID: <m3acx0szwu.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> 4) If there were no errors detecting by the fsck run, run the command
> "tune2fs -C 0 -T now /dev/XXX" on the live filesystem.  This sets the
> mount count and last filesystem checked time to the appropriate values
> in the superblock.

Is it safe now to run tune2fs on a mounted busy fs? afaik it would
need at least support to quiescence the fs temporarily. Otherwise you 
have a race window where changes to the superblock could get lost.

-Andi

