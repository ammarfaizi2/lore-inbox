Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262411AbSJERHT>; Sat, 5 Oct 2002 13:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262412AbSJERHT>; Sat, 5 Oct 2002 13:07:19 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:41960 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262411AbSJERHS>; Sat, 5 Oct 2002 13:07:18 -0400
Date: Sat, 5 Oct 2002 19:12:45 +0200
From: Patrick.Mau@t-online.de (Patrick Mau)
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.40 (BK of today) vmstat SIGSEGV after reading /proc/stat
Message-ID: <20021005171245.GA3060@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo List,

The BK tree of today changed the data returned in /proc/stat.
A 'vmstat -n 10' immediatly segfaults after reading ...

open("/proc/stat", O_RDONLY)            = 6
read(6, "cpu  404408 506514 8240 154301 1"..., 4095) = 714
close(6)                                = 0
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

I'll try to prove a diff between 2.4.18 and BK current later
this evening ...

cheers,
Patrick
