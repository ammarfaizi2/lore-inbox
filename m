Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265950AbRFZIoC>; Tue, 26 Jun 2001 04:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265953AbRFZInw>; Tue, 26 Jun 2001 04:43:52 -0400
Received: from www.wen-online.de ([212.223.88.39]:10762 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S265950AbRFZIni>;
	Tue, 26 Jun 2001 04:43:38 -0400
Date: Tue, 26 Jun 2001 10:42:31 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Rik van Riel <riel@conectiva.com.br>
Subject: a repeatable way to stall vm?
Message-ID: <Pine.LNX.4.33.0106261019400.303-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I stumbled onto a strange behavior which may or may not be related
to the stalls reported by a couple of people.

What I did, was to run bonnie in tmpfs to beat up the swap code a
bit.  My setup is 128mb ram, and 256mb swap on /dev/hda2, single
spindle.  All runs very smoothly (tremendous write throughput btw),
doing bonnie -s 240.

I then added a second partition (/dev/hda5) as sequential addon,
and tried bonnie -s 500.  As soon as it crosses over to the second
partition, I see terrible stalls with no disk activity for seconds
at a time.

Interrupting bonnie leaves the file in place.  As long as this file
was present, the box was very unresponsive.. mouse (I'm not running X)
jumped around badly etc.  rm'd, and responsiveness instantly returned.

	-Mike

