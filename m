Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSFXVsO>; Mon, 24 Jun 2002 17:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSFXVsN>; Mon, 24 Jun 2002 17:48:13 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:45548 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S315334AbSFXVsM>; Mon, 24 Jun 2002 17:48:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: linux-kernel@vger.kernel.org
Subject: buffer layer error in 2.5.24
Date: Mon, 24 Jun 2002 23:51:33 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020624214812Z315334-22020+10139@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.5.24 with 2.5.24-kg3 applied

got this error:
buffer layer error at page-writeback.c:524
Pass this trace through ksymoops for reporting
<trace>

passed through ksymoops:
ksymoops 2.4.3 on i686 2.5.24.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.24 (specified)
     -m /boot/System.map-2.5.24 (specified)

Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in 
System.map.  Ignoring ksyms_base entry
Jun 24 23:22:54 gandalf kernel: cff63e88 c0241920 c02418e6 c02415b9 0000020c 
c0134701 c02415b9 0000020c
Jun 24 23:22:54 gandalf kernel:        c1203060 ce676104 ce676130 cff63f9c 
c012879e c1203060 c1203060 c01344e7
Jun 24 23:22:54 gandalf kernel:        c1203060 00000004 ce676080 ce676088 
ce676104 00000000 00000000 c0128750
Jun 24 23:22:54 gandalf kernel: Call Trace: 
[__set_page_dirty_buffers+129/224] [fail_writepage+78/96] 
[generic_writepages+375/496] [fail_writepage+0/96] [do_writepages+39/48]

1 warning issued.  Results may not be reliable.


apparently something is wrong with System.map but it is the one generated for 
this kernel...


	Rudmer	
