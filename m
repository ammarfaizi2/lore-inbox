Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRBWQKc>; Fri, 23 Feb 2001 11:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129333AbRBWQKV>; Fri, 23 Feb 2001 11:10:21 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:57100 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129165AbRBWQKL>; Fri, 23 Feb 2001 11:10:11 -0500
From: Mike Ashton <mike@parasolsolutions.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 bug in mkdir(2)
Message-Id: <E14WKnI-00012v-00@mail1.london.parasolsolutions.com>
Date: Fri, 23 Feb 2001 16:10:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mkdir("file", 02750) does not create a file with the set group id bit
set.  chmod("file", 02750) does.  Further more, mkdir(2) violates its
man page specification by not creating set-gid directories if the
parent directory has this bit set.

I suspect these are related.

Cheers,
Mike.

