Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbSLRVCt>; Wed, 18 Dec 2002 16:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbSLRVCt>; Wed, 18 Dec 2002 16:02:49 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:59551 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267345AbSLRVCt>;
	Wed, 18 Dec 2002 16:02:49 -0500
Message-ID: <1040245847.3e00e457a4d66@kolivas.net>
Date: Thu, 19 Dec 2002 08:10:47 +1100
From: Con Kolivas <conman@kolivas.net>
To: kernel@mailsammler.de
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>So copied everything away to a software raid and tried all the disk 
>tuning stuff (min-, max-readahead, bdflush, elvtune). Nothing helped. 
>Last Sunday I then found a hint about a bug introduced in kernel 
>2.4.19-pre6 which could be fixed using a "dlh", disk latency hack - or 
>going back to 2.4.18. Last is what I did ( from 2.4.20 )

I made the dlh (disk latency hack) and it is related to a problem of system
response under heavy IO load, NOT the actual IO throughput so this sounds
unrelated. However, I have seen what you describe with reiserFS and ide raid at
least and had it fixed by applying AA's stuck in D fix, which ReiserFS is more
prone to for some complicated reason. Give that a go.

In 

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/

it is patch 9980_fix-pausing-2         

Regards,
Con
