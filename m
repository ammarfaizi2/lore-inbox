Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbTKSOSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264078AbTKSOSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:18:33 -0500
Received: from eik.ii.uib.no ([129.177.16.3]:58356 "EHLO mail.ii.uib.no")
	by vger.kernel.org with ESMTP id S264074AbTKSOSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:18:31 -0500
Subject: Re: 2.6.0-test9-mm4 - kernel BUG at arch/i386/mm/fault.c:357!
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031119140222.GV22764@holomorphy.com>
References: <1069246427.5257.12.camel@localhost.localdomain>
	 <20031119130220.GT22764@holomorphy.com>
	 <1069248455.5257.26.camel@localhost.localdomain>
	 <20031119140222.GV22764@holomorphy.com>
Content-Type: text/plain
Message-Id: <1069251503.3390.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 19 Nov 2003 15:18:23 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.9 (+)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AMTA3-0005cL-00*ZpZVpNYlKDY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 15:02, William Lee Irwin III wrote:
> On Wed, 2003-11-19 at 14:02, William Lee Irwin III wrote:
> >> What sound card?
> 
> On Wed, Nov 19, 2003 at 02:27:36PM +0100, Ronny V. Vindenes wrote:
> > Hercules Fortissimo III (snd-cs46xx), there's also a Terratec EWX24/96
> > (snd-ice1712) installed but it's not in active use.
> 
> Er, sorry, try this one instead:
> 

bad nopage snd_pcm_mmap_data_nopage+0x0/0xc0 [snd_pcm]
handle_mm_fault() returned bad status
------------[ cut here ]------------
kernel BUG at arch/i386/mm/fault.c:362!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c011c523>]    Not tainted VLI
EFLAGS: 00010286
EIP is at do_page_fault+0x3a3/0x530
eax: 00000029   ebx: f4770040   ecx: f79fd340   edx: f3ff4000
esi: f4770060   edi: f4d13780   ebp: f5271340   esp: f3ff5f10
ds: 007b   es: 007b   ss: 0068
Process et.x86 (pid: 3223, threadinfo=f3ff4000 task=f5271340)
Stack: c0367680 f89e6f20 5753b664 00000001 00000001 5753b664 00000000
0240d793
       00030002 00001000 f3ff4000 c0000000 f5464400 00000000 f89e6868
f7792c80
       80044121 f3ff5f70 bffef4e4 f5464400 f8e325b2 bffef4e4 f3ff5f74
0000000c
Call Trace:
 [<f89e6f20>] snd_pcm_mmap_data_nopage+0x0/0xc0 [snd_pcm]
 [<f89e6868>] snd_pcm_kernel_playback_ioctl+0x38/0x50 [snd_pcm]
 [<f8e325b2>] snd_pcm_oss_get_ptr+0x82/0x1e0 [snd_pcm_oss]
 [<c01727e0>] sys_ioctl+0xe0/0x2c0
 [<c011c180>] do_page_fault+0x0/0x530
 [<c035050f>] error_code+0x2f/0x38
                                                                                
Code: 24 b0 00 00 00 04 0f 84 7c fd ff ff e9 59 fe ff ff 8b 47 30 85 c0
74 07 8b 40 08 85 c0 75 55 c7 04 24 80 76 36 c0 e8 2d 6c 00 00 <0f> 0b
6a 01 12 73 36 c0 8b 94 24 ac 00 00 00 f6 42 32 02 74 1f


-- 
Ronny V. Vindenes <s864@ii.uib.no>

