Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbRCTOsO>; Tue, 20 Mar 2001 09:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbRCTOsE>; Tue, 20 Mar 2001 09:48:04 -0500
Received: from mailman.techspan.com ([4.21.76.5]:30986 "EHLO
	mailman.techspan.com") by vger.kernel.org with ESMTP
	id <S130380AbRCTOrv>; Tue, 20 Mar 2001 09:47:51 -0500
Message-ID: <3AB76D5D.9EE0C1A7@yahoo.com>
Date: Tue, 20 Mar 2001 09:46:53 -0500
From: Mark Swanson <swansma@yahoo.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: 2.4.2-ac20 USB suspend oops message
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Reproducable 100% of the time. I have 1 mouse plugged into my uhci port.
When I suspend I get:

Mar 20 09:09:33 laptop kernel: Unable to handle kernel paging request at

virtual address 6273754b
Mar 20 09:09:33 laptop kernel:  printing eip:
Mar 20 09:09:33 laptop kernel: cc86d58b
Mar 20 09:09:33 laptop kernel: pgd entry c74b6624: 0000000000000000
Mar 20 09:09:33 laptop kernel: pmd entry c74b6624: 0000000000000000
Mar 20 09:09:33 laptop kernel: ... pmd not present!
Mar 20 09:09:33 laptop kernel: Oops: 0000
Mar 20 09:09:33 laptop kernel: CPU:    0
Mar 20 09:09:33 laptop kernel: EIP:    0010:[<cc86d58b>]
Mar 20 09:09:33 laptop kernel: EFLAGS: 00010093
Mar 20 09:09:33 laptop kernel: eax: 4f525000   ebx: c84747e0   ecx:
c765c120
edx: 00000001
Mar 20 09:09:33 laptop kernel: esi: 6273752f   edi: c765c158   ebp:
c7489f2c
esp: c7489f0c

ksymoops:
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
ksyms_base entry
Mar 20 09:09:33 laptop kernel: Unable to handle kernel paging request at

Mar 20 09:09:33 laptop kernel: cc86d58b
Mar 20 09:09:33 laptop kernel: Oops: 0000
Mar 20 09:09:33 laptop kernel: CPU:    0
Mar 20 09:09:33 laptop kernel: EIP:    0010:[<cc86d58b>]
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 20 09:09:33 laptop kernel: EFLAGS: 00010093
Mar 20 09:09:33 laptop kernel: eax: 4f525000   ebx: c84747e0   ecx:
c765c120
Mar 20 09:09:33 laptop kernel: esi: 6273752f   edi: c765c158   ebp:
c7489f2c
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; cc86d58b <[uhci]uhci_call_completion+8b/164>   <=====


2 warnings issued.  Results may not be reliable.


