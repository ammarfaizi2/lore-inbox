Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283501AbRLCXqW>; Mon, 3 Dec 2001 18:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRLCXlm>; Mon, 3 Dec 2001 18:41:42 -0500
Received: from mustard.heime.net ([194.234.65.222]:41885 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284546AbRLCNNf>; Mon, 3 Dec 2001 08:13:35 -0500
Date: Mon, 3 Dec 2001 14:13:22 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: tuning ext2 or ReiserFS to avoid fragmentation with large files?
Message-ID: <Pine.LNX.4.30.0112031404030.7944-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I've got this server with lots of ~3GB files and every now and then we
need to add some more or delete some old ones. All files are potentially
read concurrently, so to reduce disk seeks, I've increased the readahead
settings in kernel (/proc/sys/vm/(min|max)-readahead).

Then... A friend of mine told me I could tune the fs (or vfs) to allocate
n kB each time a file is created, and by setting this to whatever I've set
(min|max)-readahead to (currently 1048576), I will reduce the negative
effect of fragmentation to a minimum, since the data blocks will be large,
and read more-or-less sequencially.

Can anyone tell me how to tell the fs or the kernel to allocate n pages/kB
this way? Is it possible? Can I possibly set different sizes per file
system?

Thanks

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


