Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272957AbTG3Gpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272956AbTG3Gpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:45:45 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:43974 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272949AbTG3Gpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:45:43 -0400
Date: Tue, 29 Jul 2003 23:17:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1011] New: aironet scheduling while atomic 
Message-ID: <14230000.1059545836@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1011

           Summary: aironet scheduling while atomic
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: mbm+kernel@nerdfest.org


Distribution: debian
Hardware Environment: dell inspiron 2650
Problem Description:

airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:40:96:32:77:21
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 7, io 0x0100-0x013f
bad: scheduling while atomic!
Call Trace:
 [<c011b12f>] schedule+0x3b6/0x3bb
 [<e1956b5d>] sendcommand+0xa2/0xcd [airo]
 [<e1956a8b>] issuecommand+0x63/0x93 [airo]
 [<e1956ff4>] PC4500_accessrid+0x4c/0x82 [airo]
 [<e1957089>] PC4500_readrid+0x5f/0x12b [airo]
 [<e19545c3>] readStatsRid+0x31/0x4a [airo]
 [<e1954bb9>] airo_read_stats+0x67/0x13b [airo]
 [<e1a6bee4>] __nvsym01575+0x28/0x34 [nvidia]
 [<e1a4d179>] __nvsym01540+0x49/0x90 [nvidia]
 [<c011a715>] try_to_wake_up+0xa2/0x144
 [<c011b1ae>] default_wake_function+0x2a/0x2e
 [<c013c284>] buffered_rmqueue+0xc1/0x15a
 [<c011a715>] try_to_wake_up+0xa2/0x144
 [<c013c3af>] __alloc_pages+0x92/0x30c
 [<c011b1ae>] default_wake_function+0x2a/0x2e
 [<c011af2f>] schedule+0x1b6/0x3bb
 [<c011b16a>] preempt_schedule+0x36/0x50
 [<c039ddda>] unix_stream_sendmsg+0x2c3/0x41f
 [<c023ac06>] vsnprintf+0x21a/0x47a
 [<e1954ca3>] airo_get_stats+0x16/0x20 [airo]
 [<c0351111>] dev_seq_printf_stats+0xdb/0xe2
 [<c0351140>] dev_seq_show+0x28/0x7c
 [<c016fabc>] seq_read+0x1c9/0x2ef
 [<c015295e>] vfs_read+0xe0/0x147
 [<c0152c05>] sys_read+0x42/0x63
 [<c0109207>] syscall_call+0x7/0xb

