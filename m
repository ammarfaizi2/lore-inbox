Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTJMWe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 18:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJMWe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 18:34:28 -0400
Received: from dsl093-216-237.aus1.dsl.speakeasy.net ([66.93.216.237]:26267
	"EHLO defaultvalue.org") by vger.kernel.org with ESMTP
	id S261797AbTJMWe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 18:34:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Alsa sound playback failure in 2.6.0-test7
From: Rob Browning <rlb@defaultvalue.org>
Date: Mon, 13 Oct 2003 17:34:24 -0500
Message-ID: <87smlw3gy7.fsf@raven.i.defaultvalue.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please CC me in any replies.)

This issue looks similar to a report posted earlier by someone using a
previous 2.6.0 test kernel.

Trying to run saytime on an Asus A7V600 (Via KT600 based) motherboard
using the onboard VIA audio (AD1980) produces no sound and the console
output included below.  The kernel was compiled with Debian's gcc-3.3
package, version 1:3.3.2-0pre4, and the machine has 512MB of RAM, no
swap, and had at least a couple of hundred MB free when saytime was
run.  Please let me know if I can provide any further information:

 <1>Unable to handle kernel paging request at virtual address e885c000
 printing eip:
e88c06ff
*pde = 1fdf8067
*pte = 00000000
Oops: 0002 [#3]
CPU:    0
EIP:    0060:[<e88c06ff>]    Not tainted
EFLAGS: 00010293
EIP is at snd_pcm_format_set_silence+0x5f/0x1b0 [snd_pcm]
eax: 80808080   ebx: e885b000   ecx: 000023a3   edx: 80808080
esi: 00000001   edi: e885c000   ebp: 000033a3   esp: c905df24
ds: 007b   es: 007b   ss: 0068
Process sox (pid: 1306, threadinfo=c905c000 task=ca4b7280)
Stack: 00000001 00000000 000033a3 cc4e5c00 def07f00 df20efa0 e895abd9 00000001 
       e885b000 000033a3 c9f2a540 df710200 df20efa0 c9f2a540 e895bfda df20efa0 
       def07f00 c9f2a540 dfff0240 df68f940 def1acc0 c01566de df68f940 c9f2a540 
Call Trace:
 [<e895abd9>] snd_pcm_oss_sync+0x69/0x160 [snd_pcm_oss]
 [<e895bfda>] snd_pcm_oss_release+0x2a/0xa0 [snd_pcm_oss]
 [<c01566de>] __fput+0xae/0xc0
 [<c0154da9>] filp_close+0x59/0x90
 [<c0154e41>] sys_close+0x61/0xa0
 [<c010b39b>] syscall_call+0x7/0xb

Code: f3 aa 31 c0 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 8b 6c 24 14 

Thanks, and hope this helps.
-- 
Rob Browning
rlb @defaultvalue.org and @debian.org; previously @cs.utexas.edu
GPG starting 2002-11-03 = 14DD 432F AE39 534D B592  F9A0 25C8 D377 8C7E 73A4
