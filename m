Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUEaOmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUEaOmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 10:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUEaOmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 10:42:55 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:24760 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264639AbUEaOmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 10:42:54 -0400
Subject: Re: Linux 2.6.7-rc2
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: petero2@telia.com, Andrew Morton OSDL <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1086006023.8188.34.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 May 2004 08:20:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund writes:

> If I put "#if 0" around the *wdata assignment in
> nfs_writepage_sync, the stack usage goes down to 36,
> so it looks like gcc is building a temporary structure
> on the stack and then copies the whole thing to *wdata.

This would be required because of the -Wno-strict-aliasing
option. For the 2.7.xx kernels, how about we start off by
replacing -Wno-strict-aliasing with -std=gnu99 ? It's been
5 years since 1999. The "restrict" keyword is useful too.


