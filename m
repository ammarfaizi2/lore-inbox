Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTFJUEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFJUCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:02:40 -0400
Received: from mail.webmaster.com ([216.152.64.131]:40698 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262143AbTFJUBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:01:00 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <root@chaos.analogic.com>, "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Large files
Date: Tue, 10 Jun 2003 13:14:45 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEECGDJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.53.0306100952560.4080@chaos>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> With 32 bit return values, ix86 Linux has a file-size limitation
> which is currently about 0x7fffffff. Unfortunately, instead of
> returning from a write() with a -1 and errno being set, so that
> a program can do something about it, write() executes a signal(25)
> which kills the task even if trapped. Is this one of those <expletive
> deleted> POSIX requirements or is somebody going to fix it?

	If the program were smart enough to do something sane about it, it should
be smart enough to handle the signal correctly. What do you think should
happen if a program compiled today calls 'time' in 2039? You want to shut
down the program as quickly as possible before it does something insane.

	DS


