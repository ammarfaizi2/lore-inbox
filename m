Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTDPQpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTDPQou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:44:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24193 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264514AbTDPQoj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:44:39 -0400
Date: Wed, 16 Apr 2003 12:58:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: System Call parameters
Message-ID: <Pine.LNX.4.53.0304161256130.11667@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How does the kernel get more than five parameters?

Currently...
	eax	= function code
	ebx	= first parameter
	ecx	= second parameter
	edx	= third parameter
	esi	= fourth parameter
	edi	= fifth parameter

Some functions like mmap() take 6 parameters!
Does anybody know how these parameters get passed?
I have an "ultra-light" 'C' runtime library I have
been working on and, so-far, I've got everything up
to mmap()  (in syscall.h) (89 functions) working.
I thought, maybe ebp was being used, but it doesn't
seem to be the case.

Maybe after 5 functions, there is a parameter list
passed by pointer???? I don't have a clue and I
can figure out the code, it's really obscure...


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

