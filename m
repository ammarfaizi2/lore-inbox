Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAPTm>; Fri, 1 Dec 2000 10:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLAPTd>; Fri, 1 Dec 2000 10:19:33 -0500
Received: from stork.EMBL-Heidelberg.DE ([192.54.41.54]:4149 "EHLO
	stork.EMBL-Heidelberg.DE") by vger.kernel.org with ESMTP
	id <S129183AbQLAPTT>; Fri, 1 Dec 2000 10:19:19 -0500
Date: Fri, 1 Dec 2000 15:48:49 +0100
From: "Yan P. Yuan" <Yanping.Yuan@EMBL-Heidelberg.de>
To: linux-kernel@vger.kernel.org
Subject: Is this really a kernel bug? or better fixed?
Message-ID: <Pine.SGI.4.10.10012011535220.5623-100000@swan.EMBL-Heidelberg.DE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I'm not sure where this is the right mailing list to ask this question,
but let me try. If not, could you excuse & help me to get to the right 
place to express it. Thanks, :-).

Today i've got a strange message in /var/log/message (
kernel 2.4.0-test10 updated from SuSE7.0-2.2.17-pre):
---------------------------------------------------------------------
Dec  1 13:54:46 tux kernel: kernel BUG at /usr/src/linux-2.4.0-test11/include/linux/nfs_fs.h:164!
Dec  1 13:54:46 tux kernel: invalid operand: 0000
Dec  1 13:54:46 tux kernel: CPU:    0
Dec  1 13:54:46 tux kernel: EIP:    0010:[nfs_create_request+421/456]
Dec  1 13:54:46 tux kernel: EFLAGS: 00010286
Dec  1 13:54:46 tux kernel: eax: 00000046   ebx: d56e5280   ecx: 00000000   edx: 08000000
Dec  1 13:54:46 tux kernel: esi: ed2d8860   edi: dea182c0   ebp: c37ca000   esp: c37cbe00
Dec  1 13:54:46 tux kernel: ds: 0018   es: 0018   ss: 0018
Dec  1 13:54:46 tux kernel: Process blastall (pid: 23527, stackpage=c37cb000)
Dec  1 13:54:46 tux kernel: Stack: c025f892 c025fac0 000000a4 d673eb40 00000000 00000000 ef5ff9a0 ef5ff9a0 
Dec  1 13:54:46 tux kernel:        cf8061c0 c015c82a d673eb40 c2d66390 00000000 00001000 c2d66390 ef5ff9a0 
Dec  1 13:54:46 tux kernel:        ffffffff d673eb40 fffffff4 c015d064 d673eb40 c2d66390 c2d66390 ef5ffa3c 
Dec  1 13:54:46 tux kernel: Call Trace: [tvecs+57438/124268] [tvecs+57996/124268] [nfs_readpage_async+330/456] [nfs_r
eadpage+120/192] [read_cluster_nonblocking+263/328] [filemap_nopage+608/1208] [filemap_nopage+0/1208] 
Dec  1 13:54:46 tux kernel:        [do_no_page+80/176] [handle_mm_fault+269/392] [do_page_fault+323/1000] [do_page_fa
ult+0/1000] [pipe_write+578/696] [sys_write+188/196] [error_code+52/60] 
Dec  1 13:54:46 tux kernel: Code: 0f 0b 83 c4 0c 89 7e 1c c7 46 3c 01 00 00 00 f0 ff 03 f0 ff 
-------------------------------------------------------------------------

I've seen also that lwn.net announced the availability of the
test12-pre3, but probably this problem is not reported before yet. 

PS.: 
Our system is a 4xPIII 550 Xeon  Dell with 2 GB memory and 
EtherExpress-networkcard (100Mb/s). The program "blastall" 
is a bioinformatics tool running in the threading mode. 

Best regards,

Yan

(Yanping.Yuan@EMBL)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
