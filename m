Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUGGPOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUGGPOu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbUGGPOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:14:50 -0400
Received: from lucidpixels.com ([66.45.37.187]:40400 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265207AbUGGPOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:14:47 -0400
Date: Wed, 7 Jul 2004 11:14:44 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
cc: justin.piszcz@mitretek.org
Subject: Does Optimization Effect BogoMips Value?
Message-ID: <Pine.LNX.4.60.0407071113400.24640@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three identical Virtual Machines with three different compiler flags to
compile the entire distribution, in this case, Gentoo 2004.1.

However, why are the Bogomips values different (up to +82 points
different)?

Linux tux 2.6.7-gentoo-r6 #1 Wed Jun 30 05:56:57 EDT 2004 i686 Intel(R)
Pentium(R) 4 CPU 2.60GHz GenuineIntel GNU/Linux
Gentoo 2004.1 Compiled With: "-pipe -mcpu=i386": 1515MB FREE
Calibrating delay loop... 4866.04 BogoMIPS

Linux tux 2.6.7-gentoo-r6 #1 Wed Jun 30 14:01:09 Local time zone must be
set--see zic manu i686 Intel(R) Pentium(R) 4 CPU 2.60GHz GenuineIntel
GNU/Linux
Gentoo 2004.1 Compiled With: "-Os -pipe -mcpu=i686": 1673MB FREE
Calibrating delay loop... 4882.43 BogoMIPS


Linux tux 2.6.7-gentoo-r6 #1 Wed Jun 30 13:58:50 Local time zone must be
set--see zic manu i686 Intel(R) Pentium(R) 4 CPU 2.60GHz GenuineIntel
GNU/Linux
Gentoo 2004.1 Compiled With: "-O3 -pipe -mcpu=pentium4 -march=i686 -msse
-msse2 -fomit-frame-pointer -funroll-loops -ffast-math": 1635MB FREE
Calibrating delay loop... 4800.51 BogoMIPS

