Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280911AbRKCBL1>; Fri, 2 Nov 2001 20:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280916AbRKCBLR>; Fri, 2 Nov 2001 20:11:17 -0500
Received: from cogito.cam.org ([198.168.100.2]:5138 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S280911AbRKCBLB>;
	Fri, 2 Nov 2001 20:11:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: pre7 and active pages
Date: Fri, 2 Nov 2001 19:29:32 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011103002933.190C59BA51@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using the xmm2 utility I am noticing much more space staying allocated 
in the active list with pre7.  Now meminfo reports:

MemTotal:       514136 kB
MemFree:          4868 kB
MemShared:           0 kB
Buffers:         53572 kB
Cached:         315584 kB
SwapCached:      16000 kB
Active:         318600 kB
Inactive:       145476 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514136 kB
LowFree:          4868 kB
SwapTotal:     1056760 kB
SwapFree:      1010700 kB

Which is not at all what I would expect given the logic in shrink_caches.
The active list does shrink under pressure but stays _much_ larger than
it did in pre6 and below.

Ed Tomlinson
