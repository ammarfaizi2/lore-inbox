Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263053AbSJGO1r>; Mon, 7 Oct 2002 10:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbSJGO1r>; Mon, 7 Oct 2002 10:27:47 -0400
Received: from mailx.oberberg.net ([212.102.225.4]:9231 "HELO
	mailx.oberberg.net") by vger.kernel.org with SMTP
	id <S263053AbSJGO1o>; Mon, 7 Oct 2002 10:27:44 -0400
Message-ID: <021701c26e0e$7d4449a0$0a01a8c0@3rgu5vk6e645pg>
From: "Philipp Steinkrueger" <kernel@cyberraum.de>
To: <linux-kernel@vger.kernel.org>, <linux-admin@vger.kernel.org>
Subject: Memory Problem
Date: Mon, 7 Oct 2002 16:33:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


i have a problem with memory management and i coulndt find a solution
doing web-research, so perhaps someone on the list can point me to a
document or give me another answer.

first, this is my system configuration:

linux kernel 2.4.19 with high-memory enabled because i put 2 GB Ram.
128 MB Swap Partition and a 250 MB Swap File.


The Problem appears with the mysql database server. here is the error
message:

Can't create a new thread (errno 11). If you are not out of available
memory, you
can consult the manual for a possible OS-dependent bug

and this is what cat /proc/meminfo shows while the system runs regulary:

MemTotal:      2069560 kB
MemFree:         24576 kB
MemShared:           0 kB
Buffers:         80808 kB
Cached:        1271288 kB
SwapCached:       1924 kB
Active:         737160 kB
Inactive:       861112 kB
HighTotal:     1179584 kB
HighFree:         2044 kB
LowTotal:       889976 kB
LowFree:         22532 kB
SwapTotal:      384476 kB
SwapFree:       379248 kB


Memfree is at 24 MB but i caught a meminfo when it was about 4 or 6 MB.

i am worried about the high "Cached" value. Could someone tell me if the
cached
content is to be considered as "reserved" and will not be used by programms
requesting
more memory ?

my general questions are:

1) how can i control the memory ? where can i tell the system how much
memory should be
used to cache stuff ? perhaps i can solve the problem this way.
2) what else does the kernel do when a programm spawns a new thread ? if
memory is
not the problem, what else could go wrong when creating a thread ?


If you need something else, like a memstat output, please let me know.


Thank you very much,
Philipp

