Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRIJNb1>; Mon, 10 Sep 2001 09:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268702AbRIJNbR>; Mon, 10 Sep 2001 09:31:17 -0400
Received: from gate.lanier.com ([63.71.82.253]:43761 "EHLO jita.Lanier.com")
	by vger.kernel.org with ESMTP id <S267650AbRIJNbF>;
	Mon, 10 Sep 2001 09:31:05 -0400
Message-ID: <C97ABDA0DC2DD511BA400002A50974132804E5@jdry.lanier.com>
From: "Donovan, Chris" <cdonovan@lanier.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Makefile Issue
Date: Mon, 10 Sep 2001 09:31:24 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying recently to compile a Linux kernel on a Sequent machine
under Dynix/Ptx and had a number of issues when I would run 'make dep' where
it would fail because the test command in /bin/sh does not support the -ot
option. I have only had this problem when compiling the linux kernel and I
was able to solve the problem by adding the following line to all the
Makefiles in the source:
   SHELL := <location of bash>
I realize that under linux the /bin/sh is linked to /bin/bash but that is
not always the case and the -ot option for test is not necessarily available
in /bin/sh. Would it be possible in the future to modify the makefiles or
find another way to make sure that make is using bash when it needs bash
instead of whatever the system is using for /bin/sh. I imagine something
like
   SHELL := $BASH
would work. Thanks for all the good work you guys do.
Chris Donovan
Lanier Worldwide
