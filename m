Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbTCTGlV>; Thu, 20 Mar 2003 01:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbTCTGlV>; Thu, 20 Mar 2003 01:41:21 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:49792 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261393AbTCTGlU>;
	Thu, 20 Mar 2003 01:41:20 -0500
Message-ID: <3E796530.2010707@portrix.net>
Date: Thu, 20 Mar 2003 07:52:32 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with bttv in latest bk
References: <3E78BB99.3070605@portrix.net> <87he9z7z95.fsf@bytesex.org>
In-Reply-To: <87he9z7z95.fsf@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> Jan Dittmer <j.dittmer@portrix.net> writes:
>>Is there anything specific I could try?
> 
> 
> http://bytesex.org/patches/2.5/patch-2.5.65-kraxel.gz
At least these algo-bits messages are gone. But still X restarts and tv 
image is corrupted until next reboot.

Jan

------------[ cut here ]------------
kernel BUG at drivers/media/video/bttv-risc.c:742!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c02f8de1>]    Not tainted
EFLAGS: 00013293
EIP is at bttv_overlay_risc+0x71/0x190
eax: 00000000   ebx: d9d3a6e0   ecx: 00000000   edx: 00000000
esi: d12528c0   edi: c0452004   ebp: c05bfae0   esp: ddfa3cd8
ds: 007b   es: 007b   ss: 0068
Process X (pid: 580, threadinfo=ddfa2000 task=de01a040)
Stack: c05bfae0 d1252938 000001a0 00000120 00000000 00000000 d12528c0 
d9d3a600
        ddfa3eec c05bfae0 c02f1273 c05bfae0 d9d3a6e0 c0452004 d12528c0 
ddfa3d34
        00003282 d9d3a600 d9d3a60c 00000001 00000000 debd5110 debd50c0 
00000000
Call Trace:
  [<c02f1273>] bttv_do_ioctl+0x3d3/0x15d0
  [<c0193e29>] ext3_commit_write+0x149/0x2a0
  [<c0193be0>] ext3_journal_dirty_data+0x0/0x80
  [<c013dc95>] unlock_page+0x15/0x60
  [<c013ff24>] generic_file_aio_write_nolock+0x494/0xac0
  [<c03000bf>] tuner_command+0x17f/0x270
  [<c016ffa2>] dput+0x22/0x1e0
  [<c02f721d>] bttv_call_i2c_clients+0x4d/0x50
  [<c0140675>] generic_file_aio_write+0x85/0xb0
  [<c0190c74>] ext3_file_write+0x44/0xe0
  [<c02eba24>] video_usercopy+0xb4/0x190
  [<c011f610>] scheduler_tick+0x2e0/0x2f0
  [<c012aec6>] update_process_times+0x46/0x60
  [<c012ad2b>] update_wall_time+0xb/0x40
  [<c01335b7>] rcu_check_quiescent_state+0x97/0xa0
  [<c01336aa>] rcu_process_callbacks+0xea/0x120
  [<c011130b>] timer_interrupt+0x7b/0x150
  [<c02f24ae>] bttv_ioctl+0x3e/0x70
  [<c02f0ea0>] bttv_do_ioctl+0x0/0x15d0
  [<c016b4c3>] sys_ioctl+0xf3/0x2b0
  [<c010b2f7>] syscall_call+0x7/0xb

Code: 0f 0b e6 02 e0 22 49 c0 8b 47 0c 89 46 70 8b 47 10 89 46 74



