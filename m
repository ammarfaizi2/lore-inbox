Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbSLPPfM>; Mon, 16 Dec 2002 10:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSLPPfM>; Mon, 16 Dec 2002 10:35:12 -0500
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:14805 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S266270AbSLPPfL>; Mon, 16 Dec 2002 10:35:11 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: HT Benchmarks (was: /proc/cpuinfo and hyperthreading)
Date: Mon, 16 Dec 2002 10:44:34 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJKEMCDLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <yw1xr8cigfs4.fsf@lakritspipa.e.kth.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> It's easy to write a program that displays any number of graphs
> vaguely related to the system load.  How do we know that the
> performance meter isn't lying?

We don't.

All I can say is that the performance meter seems (note the weasel-word)
proper when running Win2K SMP on a dual PIII-933 box at one of my client
sites. However, such experience does *not* guarantee that WinXP is reporting
valid numbers for a P4 with HT.

Here's a little test I ran this morning, now that my new system is
operational. My benchmark is a full "make bootstrap" compile of gcc-3.2.1,
with and without the - j 2 make switch that enables two threads of
compilation. Using the 2.5.51 SMP kernel, I see the following compile times:

  SMP     w/o  -j 2: 28m11s
  "nosmp" with -j 2: 27m32s
  SMP     with -j 2: 24m21s

HT appears to give a very tiny benefit even without an SMP kernel -- and
*with* an SMP kernel, I get a 16% improvement in my compile time. That
pretty much matches my expectation (i.e., a HT processor is *not* equal to
dual processor, but it *is* better than a non-HT processor).

Just some food for collective thought.

..Scott

