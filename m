Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTH0DNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 23:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbTH0DNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 23:13:44 -0400
Received: from smtp4.Stanford.EDU ([171.67.16.29]:15318 "EHLO
	smtp4.Stanford.EDU") by vger.kernel.org with ESMTP id S263068AbTH0DNk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 23:13:40 -0400
Date: Tue, 26 Aug 2003 20:13:23 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: mc@cs.stanford.edu
Subject: [CHECKER] 8 potential user-pointer errors in 2.6.0-test3
In-Reply-To: <Pine.GSO.4.44.0308211444420.23210-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0308262008480.12989-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Enclosed are 8 potential user-pointer errors existing in 2.6.0-test3. I
checked a different version of linux, so the line numbers could be
different. please read the warnings carefully. If you have any questions,
please let me know.

In sound/oss/opl3sa2.c, there are two potential errors that allow users
write to arbitrary kernel memory.

Confirmations or Clarifications will be greatly appreciated.

-Junfeng


-----------------------------------------
[UNKNOWN] allows arbitrary writes to the kernel
/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:539:opl3sa3_mixer_ioctl: ERROR:TAINTED:539:539: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:514:opl3sa3_mixer_ioctl: ERROR:TAINTED:514:514: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:507:opl3sa3_mixer_ioctl: ERROR:TAINTED:507:507: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:534:opl3sa3_mixer_ioctl: ERROR:TAINTED:534:534: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:543:opl3sa3_mixer_ioctl: ERROR:TAINTED:543:543: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:500:opl3sa3_mixer_ioctl: ERROR:TAINTED:500:500: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:511:opl3sa3_mixer_ioctl: ERROR:TAINTED:511:511: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:497:opl3sa3_mixer_ioctl: ERROR:TAINTED:497:497: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:528:opl3sa3_mixer_ioctl: ERROR:TAINTED:528:528: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:547:opl3sa3_mixer_ioctl: ERROR:TAINTED:547:547: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:504:opl3sa3_mixer_ioctl: ERROR:TAINTED:504:504: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa3_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa3_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:474:opl3sa3_mixer_ioctl =UP=> ]

-----------------------------------------
[UNKNOWN] allows arbitrary writes to the kernel
/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:416:opl3sa2_mixer_ioctl: ERROR:TAINTED:416:416: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:425:opl3sa2_mixer_ioctl: ERROR:TAINTED:425:425: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:462:opl3sa2_mixer_ioctl: ERROR:TAINTED:462:462: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:419:opl3sa2_mixer_ioctl: ERROR:TAINTED:419:419: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:455:opl3sa2_mixer_ioctl: ERROR:TAINTED:455:455: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:438:opl3sa2_mixer_ioctl: ERROR:TAINTED:438:438: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:447:opl3sa2_mixer_ioctl: ERROR:TAINTED:447:447: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:423:opl3sa2_mixer_ioctl: ERROR:TAINTED:423:423: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:450:opl3sa2_mixer_ioctl: ERROR:TAINTED:450:450: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:458:opl3sa2_mixer_ioctl: ERROR:TAINTED:458:458: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]

/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:442:opl3sa2_mixer_ioctl: ERROR:TAINTED:442:442: dereferencing tainted ptr 'arg' [PATH=':put_user:$2' @/home/junfeng/linux-tainted/sound/oss/ac97.c:437:ac97_mixer_ioctl =UP=> ':ac97_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:923:nm256_default_mixer_ioctl =UP=> '/home/junfeng/linux-tainted/sound/oss/nm256_audio.c:nm256_default_mixer_ioctl:' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:0:opl3sa2_mixer_ioctl =FNPTR=>'/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:opl3sa2_mixer_ioctl:$3' @/home/junfeng/linux-tainted/sound/oss/opl3sa2.c:391:opl3sa2_mixer_ioctl =UP=> ]


 -----------------------------------------
[UNKNOWN] optlen is dereferenced in sctp_getsockopt_peer_addr_params.
/home/junfeng/linux-2.5.75/net/sctp/socket.c:3104:sctp_getsockopt: ERROR:TAINTED:3104:3104: passing tainted ptr 'optlen' into 'sctp_getsockopt_peer_addr_params' [to='/u1/junfeng/linux-2.5.75/net/sctp/socket.c:sctp_getsockopt_peer_addr_params:3'] [from=' /u1/junfeng/linux-2.5.75/net/ipv4/ipmr.c:sctp_getsockopt:parm4'] [Callstack: /u1/junfeng/linux-2.5.75/net/ipv4/tcp.c:2450:sctp_getsockopt((tainted, 4)(untainted, 0))]

-----------------------------------------
[UNKNOWN] copy_from_user (pt->buf, bufptr, _) shows bufptr is in user space, while pt->buf is in kernel space. bufptr = (u16 *) pt->buf makes bufptr in kernel space. if the while (blocks >0) loop can ever loop more than once, kernel ptr will be passed into copy_from_user

/home/junfeng/linux-tainted/sound/oss/emu10k1/passthrough.c:187:emu10k1_pt_write: ERROR:TAINTED:187:187: passing untainted ptr 'bufptr' into 'copy_from_user' [to='/home/junfeng/linux-tainted/include/asm/uaccess.h:copy_from_user:$2'] [PATH=':kmalloc:$return' @/home/junfeng/linux-tainted/sound/oss/emu10k1/passthrough.c:157:emu10k1_pt_write =UP=> ] [PATH='/home/junfeng/linux-tainted/include/asm/uaccess.h:copy_from_user:$2' @/home/junfeng/linux-tainted/sound/oss/emu10k1/passthrough.c:187:emu10k1_pt_write =UP=> ]

/home/junfeng/linux-tainted/sound/oss/emu10k1/passthrough.c:187:emu10k1_pt_write: ERROR:TAINTED:187:187: passing untainted ptr 'bufptr' into 'copy_from_user' [to='/home/junfeng/linux-tainted/include/asm/uaccess.h:copy_from_user:$2'] [PATH='/home/junfeng/linux-tainted/include/asm/uaccess.h:copy_from_user:$1' @/home/junfeng/linux-tainted/sound/oss/emu10k1/passthrough.c:187:emu10k1_pt_write =UP=> ] [PATH='/home/junfeng/linux-tainted/include/asm/uaccess.h:copy_from_user:$2' @/home/junfeng/linux-tainted/sound/oss/emu10k1/passthrough.c:187:emu10k1_pt_write =UP=> ]

-----------------------------------------
[UNKNOWN] it's kinda tricky here. fbcon_set_def_font calls strncpy_from_user on op->data, which shows that it is a user pointer. fbcon_font_op calles fbcon_set_def_font, so its param op's filed op->data should also be in user space. both vgacon_do_font_op and fbcon_font_op are assigned to struct field fb_con.fcon_font_op. it coult be an error of passing kernel pointers into strncpy_from_user. it can also be that fbcon_set_def_font is a speical case.


/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:909:vgacon_font_op: ERROR:TAINTED:909:909: passing tainted ptr 'op->data' into 'vgacon_do_font_op' [to='/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:vgacon_do_font_op:$1'] [PATH=':strncpy_from_user:$2' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2299:fbcon_set_def_font =UP=> '/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:fbcon_set_def_font:$2->data' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2319:fbcon_font_op =UP=> '/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:fbcon_font_op:' @/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:0:vgacon_font_op =FNPTR=>'/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:vgacon_font_op:$2->data' @/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:900:vgacon_font_op =UP=> ] [PATH='infered_from_deref:vgacon_do_font_op:$1' @/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:790:vgacon_do_font_op =UP=> '/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:vgacon_do_font_op:$1' @/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:909:vgacon_font_op =UP=> ]

/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:917:vgacon_font_op: ERROR:TAINTED:917:917: passing tainted ptr 'op->data' into 'vgacon_do_font_op' [to='/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:vgacon_do_font_op:$1'] [PATH=':strncpy_from_user:$2' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2299:fbcon_set_def_font =UP=> '/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:fbcon_set_def_font:$2->data' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2319:fbcon_font_op =UP=> '/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:fbcon_font_op:' @/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:0:vgacon_font_op =FNPTR=>'/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:vgacon_font_op:$2->data' @/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:900:vgacon_font_op =UP=> ] [PATH='infered_from_deref:vgacon_do_font_op:$1' @/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:790:vgacon_do_font_op =UP=> '/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:vgacon_do_font_op:$1' @/home/junfeng/linux-tainted/drivers/video/console/vgacon.c:917:vgacon_font_op =UP=> ]

-----------------------------------------
[UNKNOWN] same as above
/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2027:fbcon_get_font: ERROR:TAINTED:2027:2027: passing tainted ptr 'data' into ':memcpy' [PATH=':strncpy_from_user:$2' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2299:fbcon_set_def_font =UP=> '/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:fbcon_set_def_font:$2->data' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2319:fbcon_font_op =UP=> '/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:fbcon_font_op:$2->data' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2312:fbcon_font_op =DOWN=>'/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:fbcon_get_font:$2->data' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2012:fbcon_get_font =UP=> ] [PATH=':memcpy:$1' @/home/junfeng/linux-tainted/drivers/video/console/fbcon.c:2027:fbcon_get_font =UP=> ]

-----------------------------------------
[UNKNOWN] arg is in user space. uioc_mimd = arg taints uioc_mimd. umc = uioc_mimd ->mbox taints umc (mbox is an array field, so uioc_mimd->mbox is just a pointer add). umc->xferaddr dereferences umc.

/u1/junfeng/linux-2.5.75/drivers/scsi/megaraid.c:4604:mega_n_to_m: ERROR:TAINTED:4604:4604: dereferencing tainted ptr 'umc' [from='   /u1/junfeng/linux-2.5.75/include/asm/uaccess.h:copy_from_user:parm1 arg uioc_mimd'] [Callstack: ]

-----------------------------------------
[UNKNOWN] the programmer's comments confirm that it is a real bug.
/home/junfeng/linux-tainted/net/appletalk/ddp.c:932:atrtr_ioctl: ERROR:TAINTED:932:932: passing tainted ptr 'rt.rt_dev' into '__dev_get_by_name' [to=':__dev_get_by_name:$1'] [PATH='/home/junfeng/linux-tainted/include/asm/uaccess.h:copy_from_user:*$1' @/home/junfeng/linux-tainted/net/appletalk/ddp.c:915:atrtr_ioctl =UP=> ] [PATH='/home/junfeng/linux-tainted/include/asm/string.h:strncmp:$2' @/home/junfeng/linux-tainted/net/core/dev.c:421:__dev_get_by_name =UP=> ':__dev_get_by_name:$1' @/home/junfeng/linux-tainted/net/appletalk/ddp.c:932:atrtr_ioctl =UP=> ]


