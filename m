Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTFJNm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTFJNm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:42:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61824 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261876AbTFJNmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:42:21 -0400
Date: Tue, 10 Jun 2003 09:57:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Large files
Message-ID: <Pine.LNX.4.53.0306100952560.4080@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With 32 bit return values, ix86 Linux has a file-size limitation
which is currently about 0x7fffffff. Unfortunately, instead of
returning from a write() with a -1 and errno being set, so that
a program can do something about it, write() executes a signal(25)
which kills the task even if trapped. Is this one of those <expletive
deleted> POSIX requirements or is somebody going to fix it?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

