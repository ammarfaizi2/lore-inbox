Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSJCT7r>; Thu, 3 Oct 2002 15:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261311AbSJCT7r>; Thu, 3 Oct 2002 15:59:47 -0400
Received: from r42h20.res.gatech.edu ([128.61.42.20]:15493 "EHLO
	clifford.headnut.org") by vger.kernel.org with ESMTP
	id <S261298AbSJCT7q>; Thu, 3 Oct 2002 15:59:46 -0400
Date: Thu, 3 Oct 2002 15:52:13 -0400
From: Christopher Verges <squirrel@mail.headnut.org>
To: linux-kernel@vger.kernel.org
Cc: mec@shout.net
Subject: [squirrel@mail.headnut.org: 2.5.40 test results for desktop]
Message-ID: <20021003155213.C21490@clifford.headnut.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following are problems I've discovered so far in the 2.5.40 kernel.
The third problem (about modprobe) may be sporadic...but it wasn't
happening prior to my upgrade to 2.5.40, so I included it.  Each is
labeled.  Output from ver_linux is included at the bottom of this
e-mail.



PROBLEM 1:

Under 'make menuconfig', the program crashes when selecting the "Advanced
Linux Sound Architecture" area under Sound.  An error report is
generated:

   Q> ./scripts/Menuconfig: MCmenu74: command not found

-----------------------------------------------------------------------------

PROBLEM 2:

Under the Netfilter section, when choosing 'Owner match support' as a
module, the system will not compile properly.  'make dep',
'make bzImage' and 'make modules' all work fine.  However, 'make
modules_install' will stop with an error about depmod not working
properly:

    depmod: *** Unresolved symbols in
    /lib/modules/2.5.40/kernel/net/ipv4/netfilter/ipt_owner.o
    depmod: 	next_thread
    depmod: 	find_task_by_pid

-----------------------------------------------------------------------------

PROBLEM 3:

Upon reboot of my system, I get the following error message:

    modprobe: Can't locate module char-major-10-135


-----------------------------------------------------------------------------

scripts/ver_linux shows this:
  If some fields are empty or look unusual you may have an old version.
  Compare to the current minimal requirements in Documentation/Changes.
 
  Linux earl.headnut.org 2.5.40 #1 SMP Thu Oct 3 15:19:42 EDT 2002 i686
  unknown
 
  Gnu C                  2.96
  Gnu make               3.79.1
  binutils               2.11.90.0.8
  util-linux             2.11f
  mount                  2.11g
  modutils               2.4.6
  e2fsprogs              1.23
  reiserfsprogs          3.x.0j
  Linux C Library        2.2.4
  Dynamic linker (ldd)   2.2.4
  Procps                 2.0.7
  Net-tools              1.60
  Console-tools          0.3.3
  Sh-utils               2.0.11
  Modules Loaded         emu10k1 ac97_codec 3c59x

