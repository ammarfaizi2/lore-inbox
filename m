Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268881AbTBZTWh>; Wed, 26 Feb 2003 14:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268882AbTBZTWg>; Wed, 26 Feb 2003 14:22:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13953 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268881AbTBZTWf>; Wed, 26 Feb 2003 14:22:35 -0500
Date: Wed, 26 Feb 2003 14:35:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, p_gortmaker@yahoo.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.63 PATCH][TRIVIAL]Change rtc.c ioport extend from 10h to 8h
In-Reply-To: <1046286599.4093.3.camel@vmhack>
Message-ID: <Pine.LNX.3.95.1030226142828.5091A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb 2003, Rusty Lynch wrote:

> The real time clock only needs 8 bytes, but rtc.c is reserving 10h bytes.
[SNIPPED...]

It only needs two bytes port 0x70 and port 0x71 in ix86. Since the Sparc
gets addressed differently and can only read/write words, it needs 8
bytes.  Please, if you are going to fix it, please fix it only once by
setting a different length for the different machines!
Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


