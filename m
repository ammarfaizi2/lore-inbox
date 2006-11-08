Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWKHQIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWKHQIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWKHQIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:08:52 -0500
Received: from cernmx04.cern.ch ([137.138.166.167]:16251 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1030244AbWKHQIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:08:51 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type;
	b=ZsI5vWz0Y2rSyEKB6W+xFT3X+6Spa3dCWncAvgND88WRDuQqwwh27+tWT5Vi+M/xC8VkVenqsF7JqyV8EQ5I5KYHxU6le/EA6+l74lZ2YlR/gRkCgpJ6g526y69OeY/6;
Keywords: CERN SpamKiller Note: -48 Charset: west-latin
X-Filter: CERNMX04 CERN MX v2.0 060921.0942 Release
From: Martin Weber <Martin.Weber@cern.ch>
Organization: RWTH Aachen
To: Linux List <linux-kernel@vger.kernel.org>
Subject: kernel BUG at include/linux/dcache.h:303
Date: Wed, 8 Nov 2006 17:08:43 +0100
User-Agent: KMail/1.9.1
X-Face: ULps1'$vijmn.0n2esJBV6~3TZEWaOGi6}g13GH{7g2[3qU+`tG}@N4i']B8Ba~v*CC.nF
	<O/g;0:;ovG7kSc~M$/[jneF|?o4VqVpQ}.Fg^:_`^Hy_FM?B)^Gp%*t%vhzyW=z3(^a~f
	+Zo9}j8O]Pk.[C-_!;4W$B_}PK_vxR]y0Anf("m!L&FLj!F|zvV_t/n&7AmgU8d\}DZFJ9
	8{Q&AE@AdRYX:bu*G#T#s%CEcwl0P@qeVEj;o2J5q]Z9w2j*>uaN9@gkj\(Q":0oB>@!$F
	SK<QP"0<~&Z(/HCiXeFc5w=jC<rW+4T-_;w*@[p`VP3@u:e5pbK^VD;"Uar:BI`W2g
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LEgUFdRlHXFHF3Y"
Message-Id: <200611081708.43932.Martin.Weber@cern.ch>
X-OriginalArrivalTime: 08 Nov 2006 16:08:46.0376 (UTC) FILETIME=[2B669A80:01C70350]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_LEgUFdRlHXFHF3Y
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

found the following message (see attached file), shortly after the system 
died...

Kind regards,

Martin

--Boundary-00=_LEgUFdRlHXFHF3Y
Content-Type: text/plain;
  charset="us-ascii";
  name="bug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bug.txt"

VFS: Busy inodes after unmount of shfs. Self-destruct in 5 seconds.  Have a nice day...
------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:303!
invalid opcode: 0000 [#1]
PREEMPT
Modules linked in: shfs radeon drm ipw2100 joydev
CPU:    0
EIP:    0060:[<c0169b6d>]    Tainted: P      VLI
EFLAGS: 00210246   (2.6.17-gentoo-r8-mkw #3)
EIP is at __follow_mount+0x7d/0x90
eax: 00000000   ebx: dff63140   ecx: d0f5a000   edx: dcec3dac
esi: d0f5be0c   edi: 00000001   ebp: d0f5be0c   esp: d0f5bd90
ds: 007b   es: 007b   ss: 0068
Process emacs-21 (pid: 9321, threadinfo=d0f5a000 task=d42fe070)
Stack: dff631c0 d46776e4 d475dac4 d0f5bf2c d0f5be00 c0169bdf d9c57dac d0f5be00
d726b200 dff63cc0 c0174873 df6e9668 c0476548 cf266010 d0f5be00 da34a5cc
000324b8 c016b331 df6e9668 d726b230 c5667894 d0f5bf2c cf26600d 00000000
Call Trace:
<c0169bdf> do_lookup+0x5f/0x180  <c0174873> dput+0x33/0x1a0
<c016b331> __link_path_walk+0x151/0xf60  <c016c19c> link_path_walk+0x5c/0x100
<c0158e6e> get_unused_fd+0x5e/0xe0  <c016c457> do_path_lookup+0xa7/0x270
<c015c326> get_empty_filp+0x46/0x110  <c016d1e4> __path_lookup_intent_open+0x54/0xa0
<c016d3c2> open_namei+0x72/0x720  <c012ff62> enqueue_hrtimer+0x62/0xa0
<c015923a> do_filp_open+0x3a/0x70  <c0158e6e> get_unused_fd+0x5e/0xe0
<c01592c3> do_sys_open+0x53/0x100  <c01593c7> sys_open+0x27/0x30
<c0102db7> sysenter_past_esp+0x54/0x75
Code: 56 04 bf 01 00 00 00 8b 5a 54 85 db 74 14 8b 06 89 54 24 04 89 04 24 e8 a2 0e 01 00 85 c0 89 c3 75 a2 83 c4 08 89 f8 5b
 5e 5f c3 <0f> 0b 2f 01 9a 7b 39 c0 eb c8 89 f6 8d bc 27 00 00 00 00 83 ec
EIP: [<c0169b6d>] __follow_mount+0x7d/0x90 SS:ESP 0068:d0f5bd90

--Boundary-00=_LEgUFdRlHXFHF3Y--
