Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268112AbRG0VMV>; Fri, 27 Jul 2001 17:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268087AbRG0VML>; Fri, 27 Jul 2001 17:12:11 -0400
Received: from maila.telia.com ([194.22.194.231]:4348 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S268112AbRG0VL6>;
	Fri, 27 Jul 2001 17:11:58 -0400
Message-Id: <200107272112.f6RLC3d28206@maila.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8-pre1 and dbench -20% throughput
Date: Fri, 27 Jul 2001 23:08:04 +0200
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all,

I have done some throughput testing again.
Streaming write, copy, read, diff are almost identical to earlier 2.4 kernels.
(Note: 2.4.0 was clearly better when reading from two files - i.e. diff - 
15.4 MB/s v. around 11 MB/s with later kenels - can be a result of disk 
layout too...)

But "dbench 32" (on my 256 MB box) results has are the most interesting:

2.4.0 gave 33 MB/s
2.4.8-pre1 gives 26.1 MB/s (-21%)

Do we now throw away pages that would be reused?

[I have also verified that mmap002 still works as expected]

/RogerL
