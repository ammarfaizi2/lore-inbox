Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275255AbRJAQgB>; Mon, 1 Oct 2001 12:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275260AbRJAQfv>; Mon, 1 Oct 2001 12:35:51 -0400
Received: from mail.spylog.com ([194.67.35.220]:7829 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S275255AbRJAQfl>;
	Mon, 1 Oct 2001 12:35:41 -0400
Date: Mon, 1 Oct 2001 20:32:03 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <921452911726.20011001203203@spylog.com>
To: linux-kernel@vger.kernel.org
Subject: Swapping in 2.4.10.SuSE-3 (2.4.10aa1 + some patches).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, folks,

        Kernel 2.4.10.SuSE-3 + patches from Andrea (from LKML), 1 CPU, 1 Gb RAM,
4 Gb swap. Mysql going to swap, but server has about 700Mb free memory:

buran:~ # vmstat 2
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0 335984 686688   6392 194476   3   6   126   167  172    83   4   1  94
 0  0  0 335984 686688   6392 194476   0   0     0     0  102    11   0   0 100

        Result of "top" command:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1190 root       9   0  1220 1020   876 S     0.0  0.0   0:00 sh
 1210 root       9   0   964  732   728 S     0.0  0.0   0:00 safe_mysqld
 1245 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
 1247 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
 1248 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
 1249 mysql      9   0  318M  624   612 S     0.0  0.0   0:17 mysqld.42
 1250 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
 1251 mysql      9   0  318M  624   612 S     0.0  0.0   0:29 mysqld.42
 1252 mysql      9   0  318M  624   612 S     0.0  0.0   1:06 mysqld.42
 1253 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
 1254 mysql      9   0  318M  624   612 S     0.0  0.0   0:00 mysqld.42
 1259 mysql      9   0  318M  624   612 S     0.0  0.0  26:01 mysqld.42

        No error messages in dmesg and syslog.

        It is normal ?

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

