Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263469AbRFRFQO>; Mon, 18 Jun 2001 01:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263473AbRFRFQE>; Mon, 18 Jun 2001 01:16:04 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:32204 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S263469AbRFRFPy>; Mon, 18 Jun 2001 01:15:54 -0400
Message-ID: <3B2D8ED0.40B299B5@kegel.com>
Date: Sun, 17 Jun 2001 22:17:04 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: getrusage vs /proc/pid/stat?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to monitor CPU, memory, and I/O utilization in a 
long-running multithreaded daemon under kernels 2.2, 2.4,
and possibly also Solaris (#ifdefs are ok).

getrusage() looked promising, and might even work for CPU utilization.
Dunno if it returns info for all child threads yet, haven't tried it.
In Linux, though, getrusage() doesn't return any info about RAM.

I know I can get the RSS and VSIZE under Linux by parsing /proc/pid/stat,
but was hoping for a faster interface (although I suppose a seek,
a read, and an ascii parse isn't *that* slow).  Is /proc/pid/stat
the only way to go under Linux to monitor RSS?
- Dan

-- 
"A computer is a state machine.
 Threads are for people who can't program state machines."
         - Alan Cox
