Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262935AbTCSGgr>; Wed, 19 Mar 2003 01:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262936AbTCSGgr>; Wed, 19 Mar 2003 01:36:47 -0500
Received: from paperi.ton.tut.fi ([193.166.234.15]:21181 "EHLO
	paperi.ton.tut.fi") by vger.kernel.org with ESMTP
	id <S262935AbTCSGgq>; Wed, 19 Mar 2003 01:36:46 -0500
Date: Wed, 19 Mar 2003 08:47:43 +0200
From: Juha Poutiainen <pode@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: L2 cache detection in Celeron 2GHz (P4 based)
Message-ID: <20030319064743.GA1683@a28a>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Kernel doesn't seem to detect L2 cache in 2GHz Pentium4 based Celeron. 
Most likely it is working normally (BIOS detects it and no system speed 
is ok), but it's not shown in dmesg or /proc/cpuinfo.

x86info shows that there is something with descriptor 0x3b, and 0x3c 
seems to be 256K L2 cache. So I guess it is as simple as adding a line:

          { 0x3B, LVL_2,      128 },

in arch/i386/kernel/setup.c  after line 2204 (2.4.20) and
in arch/i386/kernel/cpu/intel.c  after line 102 (2.5.65)

I've tried both, they seems to report it fine, but I can't be sure if 
that really is correct id of that cache. Celeron at issue has 128K L2 
cache.

--
pode
