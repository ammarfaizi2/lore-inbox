Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbTCJRZp>; Mon, 10 Mar 2003 12:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbTCJRZp>; Mon, 10 Mar 2003 12:25:45 -0500
Received: from franka.aracnet.com ([216.99.193.44]:50825 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261389AbTCJRZn>; Mon, 10 Mar 2003 12:25:43 -0500
Date: Mon, 10 Mar 2003 09:36:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 456] New: Apache test framework causes kernel panic in tcp_v4_get_port
Message-ID: <9610000.1047317781@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



http://bugme.osdl.org/show_bug.cgi?id=456

           Summary: Apache test framework causes kernel panic in
                    tcp_v4_get_port
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: davem@vger.kernel.org
         Submitter: thom@planetarytramp.net


Distribution: Debian Gnu/Linux unstable 
Hardware Environment: AMD Athlon(tm) XP 1800+; 246Mb RAM, Realtek 8139too
Software Environment: 
17:11 /usr/src/linux-2.5.64% sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux samizdat 2.5.64 #1 Fri Mar 7 17:29:51 GMT 2003 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      0.9.10
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.8
Modules Loaded         

Problem Description: When running the httpd test framework for the apache web
server, 2.5 series kernels reproducibly kernel panic (tried with 2.5.59,
.64-mm1, and vanilla .64)

Steps to reproduce:
install apache2 or apache including headers and apxs.
checkout the perl testing framework.
(see http://httpd.apache.org/dev/anoncvs.txt for login details)
cvs -d:pserver:anoncvs@cvs.apache.org:/home/cvspublic co httpd-test/perl-framework
ensure that you have the required perl modules installed.
run the perl framework (I've been running in SMOKE mode) t/SMOKE.
After approx 20-25 mins the kernel panics.

------- Additional Comment #1 From Thom May  2003-03-10 09:27 -------

Created an attachment (id=219)
Stack trace from the kernel panic after running through ksymoops.

Unfortunately I didn't have ksyms compiled in.


