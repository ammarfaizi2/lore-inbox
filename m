Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311272AbSCQDK6>; Sat, 16 Mar 2002 22:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311273AbSCQDKt>; Sat, 16 Mar 2002 22:10:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19214 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311272AbSCQDKg>; Sat, 16 Mar 2002 22:10:36 -0500
Subject: Re: /dev/md0: Device or resource busy
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Sun, 17 Mar 2002 03:26:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203161709140.7016-100000@twinlark.arctic.org> from "dean gaudet" at Mar 16, 2002 05:44:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mRJX-00082B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i have 3 other md devices which i can stop no problem (even with 0xfd
> autodetection), just not /dev/md0.
> 
> % raidstop /dev/md0
> /dev/md0: Device or resource busy
> 
> i don't have any filesystem mounted on md0, and "lsof | grep md" doesn't
> show anything.

lsof isnt always the most reliable to tools if a kernel thread or nfs
ran off with it. Is md0 doing anything else - like rebuilding. Is there
anything that has been triggered or run from it - paticularly kernel
threads
