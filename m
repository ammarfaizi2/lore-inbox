Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWGPQQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWGPQQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWGPQQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:16:38 -0400
Received: from gob75-2-82-67-192-40.fbx.proxad.net ([82.67.192.40]:3005 "EHLO
	httrack.net") by vger.kernel.org with ESMTP id S1751596AbWGPQQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:16:37 -0400
X-Spam-Filter: check_local@httrack.net by digitalanswers.org
Date: Sun, 16 Jul 2006 18:16:31 +0200
From: Xavier Roche <roche+kml2@exalead.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060716161631.GA29437@httrack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (httrack.net [127.0.0.1]); Sun, 16 Jul 2006 18:16:35 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It simply the best filesystem for many kinds of usage patterns.

The most frightening too. Reiserfs might be suitable for very specific appliactions, but to use it in production machine, you need to have some guts.

My last reiserfs partition was blown up two days ago, because of a bad sector, plus a fatal oops, looping endlessly. This was the second time, and the last one, as none of my ext3 filesystems *ever* had similar problems, despite numerous other bad sector issues. Not mentionning the funny "recovery" tool, which generally finishes to trash your data.

Jul 14 23:35:29 linux kernel: hdh: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jul 14 23:35:29 linux kernel: hdh: dma_intr: error=0x40 { UncorrectableError }, LBAsect=12458384, sector=12458383
Jul 14 23:35:29 linux kernel: ide: failed opcode was: unknown
Jul 14 23:35:29 linux kernel: end_request: I/O error, dev hdh, sector 12458383
Jul 14 23:35:29 linux kernel: ------------[ cut here ]------------
Jul 14 23:35:29 linux kernel: kernel BUG at fs/reiserfs/file.c:620!
..
Jul 14 23:35:29 linux kernel:  <0>Fatal exception: panic in 5 seconds

The funny part is that 14 july is the french's fireworks day, generally launched around midnight.
