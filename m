Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTKCEsI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 23:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTKCEsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 23:48:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:11495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbTKCEsD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 23:48:03 -0500
Date: Sun, 2 Nov 2003 20:45:56 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What do frame pointers do?
Message-Id: <20031102204556.0c5b377a.rddunlap@osdl.org>
In-Reply-To: <20031102170029.59013.qmail@web40908.mail.yahoo.com>
References: <20031102170029.59013.qmail@web40908.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003 09:00:29 -0800 (PST) Bradley Chapman <kakadu_croc@yahoo.com> wrote:

| What exactly is the purpose of a frame pointer? As far back as I can remember, 2.4
| and 2.6 kernels have supported something called a frame pointer, which slows down
| the kernel slightly but supposedly outputs 'very useful debugging information.'
| Unfortunately, it doesn't really explain what they are, and for the past few months,
| I haven't seen any hacker gods asking for CONFIG_FRAME_POINTER=y, except for Russell
| King, who wants them compiled for ARM processors for some reason (I grepped the
| kernel source looking for answers and found a comment which implied this).
| 
| Does anyone know where I can find a good explanation of what they are and what they
| do?

Frame pointers enable more deterministic back tracing of the stack,
which can be helpful for tracking down bugs.  I build with
CONFIG_FRAME_POINTER enabled all of the time.

Note, however, that current 2.6.x Makefile does not allow frame pointers
to be used with gcc 2.96 since it has some known problems with code generation
when using frame pointers.

There is a little discussion of frame pointers in the Intel
IA-32 Intel® Architecture Software Developer;s Manual Volume 1:
Basic Architecture
and
IA-32 Intel® Architecture Software Developer's Manual Volume 2:
Instruction Set Reference,
which are downloadable as .pdf files from developer.intel.com.

--
~Randy
