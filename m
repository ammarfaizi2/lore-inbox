Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265079AbUEYThY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUEYThY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUEYThY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:37:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:36052 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265079AbUEYTge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:36:34 -0400
Date: Tue, 25 May 2004 21:34:58 +0200
From: Olaf Hering <olh@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
Message-ID: <20040525193458.GA21120@suse.de>
References: <20040525184732.GB26661@suse.de> <Pine.LNX.4.53.0405251457450.582@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0405251457450.582@chaos>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, May 25, Richard B. Johnson wrote unrelated stuff:

did you actually try it?

(none):~ # /usr/bin/time dd if=/dev/sdb bs=1M count=123  of=/dev/null
123+0 records in
123+0 records out
0.00user 0.75system 0:17.13elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+426minor)pagefaults 0swaps
(none):~ # /usr/bin/time dd if=/dev/sdb bs=1M count=123  of=/dev/null 
123+0 records in
123+0 records out
0.00user 0.74system 0:15.66elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+426minor)pagefaults 0swaps
(none):~ # /usr/bin/time dd if=/dev/sdb bs=1M count=123  of=/dev/null 
123+0 records in
123+0 records out
0.00user 0.78system 0:15.67elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+426minor)pagefaults 0swaps
(none):~ # /usr/bin/time dd if=/tmp/sdb bs=1M count=123  of=/dev/null 
123+0 records in
123+0 records out
0.00user 0.47system 0:06.44elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+426minor)pagefaults 0swaps
(none):~ # /usr/bin/time dd if=/tmp/sdb bs=1M count=123  of=/dev/null 
123+0 records in
123+0 records out
0.00user 0.47system 0:06.44elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+426minor)pagefaults 0swaps
(none):~ # /usr/bin/time dd if=/tmp/sdb bs=1M count=123  of=/dev/null 
123+0 records in
123+0 records out
0.00user 0.50system 0:06.44elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+426minor)pagefaults 0swaps


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
