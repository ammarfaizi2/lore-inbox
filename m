Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSHUGVK>; Wed, 21 Aug 2002 02:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSHUGVK>; Wed, 21 Aug 2002 02:21:10 -0400
Received: from gremlin.ics.uci.edu ([128.195.1.70]:29089 "HELO
	gremlin.ics.uci.edu") by vger.kernel.org with SMTP
	id <S317888AbSHUGVJ>; Wed, 21 Aug 2002 02:21:09 -0400
Date: Tue, 20 Aug 2002 23:25:11 -0700 (PDT)
From: Mukesh Rajan <mrajan@ics.uci.edu>
To: linux-kernel@vger.kernel.org
Subject: detecting hard disk idleness
Message-ID: <Pine.SOL.4.20.0208202316380.20323-100000@hobbit.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'm trying to implement an alogrithm that requires as input the idleness
period of a hard disk (i.e. time between satisfying a request and arrival
of new request).

so far implementation polls "proc/stat" periodically to detect idleness
over the poll period. this implementation is not accurate and also i have
very small poll interval (milli secs). with some measurements, conclusion
is that implementation is consuming quite some power. this millisecond
polling overhead could be avoided if i can come up with an interrupt
driven implementation. in DOS, i would have manipulated the interrupt
table and inserted my code for 13h (disk interrupt right?). this would
help me do some preprocessing before the actual call to the hard disk
(13h).

is this possible in any way in Linux? i.e. have the kernel inform a
program when a hard disk interrupt occurs? either through interrupt
manipulation or otherwise?

- mukesh



