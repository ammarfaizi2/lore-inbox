Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbTI2Pyj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTI2Pyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:54:38 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:53647 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263641AbTI2Px1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:53:27 -0400
Date: Mon, 29 Sep 2003 08:52:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: anovikov@artezio.ru
Subject: [Bug 1288] New: Oops in snd_pcm_oss
Message-ID: <43470000.1064850750@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Oops in snd_pcm_oss
    Kernel Version: 2.6.0-test6
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: anovikov@artezio.ru


Distribution: Red Hat Linux 9 
Hardware Environment: Multimedia audio controller: Intel Corp. 82801DB AC'97 
Audio, Intel 845GL 
Software Environment: 
Problem Description: 
dmesg gains the following information: 
Unable to handle kernel paging request at virtual address e07d2000 
 printing eip: 
e02107be 
*pde = 1ab24067 
*pte = 00000000 
Oops: 0002 [#1] 
CPU:    0 
EIP:    0060:[<e02107be>]    Not tainted 
EFLAGS: 00010202 
EIP is at snd_pcm_format_set_silence+0x94/0x1c4 [snd_pcm] 
eax: 00000000   ebx: 00000002   ecx: 000001e0   edx: 00001780 
esi: 00000bc0   edi: e07d2000   ebp: d3df9f28   esp: d3df9f14 
ds: 007b   es: 007b   ss: 0068 
Process sox (pid: 1629, threadinfo=d3df8000 task=d3e8ccc0) 
Stack: 00000002 e07eb5b8 00000bc0 d33b8000 de3ad580 d3df9f48 
e07ebb0d 00000002 
       e07d1000 00000bc0 d3375d80 d61f9280 def09c00 d3df9f64 e07ecfe1 
d61f9280 
       00000000 d3375d80 00000000 df7341c0 d3df9f88 c0156305 de54fe38 
d3375d80 
Call Trace: 
 [<e07eb5b8>] snd_pcm_oss_write1+0x152/0x1f0 [snd_pcm_oss] 
 [<e07ebb0d>] snd_pcm_oss_sync+0x69/0x162 [snd_pcm_oss] 
 [<e07ecfe1>] snd_pcm_oss_release+0x23/0xdb [snd_pcm_oss] 
 [<c0156305>] __fput+0x118/0x12a 
 [<c01549ed>] filp_close+0x57/0x81 
 [<c0154a7b>] sys_close+0x64/0x96 
 [<c010a2f5>] sysenter_past_esp+0x52/0x71 
Steps to reproduce: 
Just try to play some .wav file via "play".


