Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVEZNy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVEZNy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVEZNy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:54:59 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:55981 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261451AbVEZNy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:54:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
Date: Thu, 26 May 2005 15:54:53 +0200
User-Agent: KMail/1.8
Cc: "J.A. Magallon" <jamagallon@able.es>, tomlins@cam.org,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
References: <20050525134933.5c22234a.akpm@osdl.org> <1117093392l.17165l.0l@werewolf.able.es> <20050526005841.08a8aae0.akpm@osdl.org>
In-Reply-To: <20050526005841.08a8aae0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261554.54807.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 26 of May 2005 09:58, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > 
> > On 05.26, Andrew Morton wrote:
> > > 
> > > (Added alsa-devel to cc)
> > > 
> > > Ed Tomlinson <tomlins@cam.org> wrote:
> > > > 
> > > > Got the following when I tried to use sound.  Anyone else see problems in alsa land?
> > > > 
> > 
> > Me too. As beep-media-player ends playing a mp3 track, oops !
> 
> hm, OK, you're also on x86_64.  What sound card and driver?

I've got the following on a dual-Opteron box with Tyan Thunder K8W (snd_intel8x0):

Unable to handle kernel paging request at 00002aaaaab2f098 RIP: 
<ffffffff880b5da7>{:snd_pcm:snd_pcm_mmap_data_close+7}
PGD 178b1067 PUD 178b2067 PMD 178a3067 PTE 0
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: usbserial floppy nvram snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd ohci_hcd usbcore joydev sg sr_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 4201, comm: artsd Not tainted 2.6.12-rc5-mm1
RIP: 0010:[<ffffffff880b5da7>] <ffffffff880b5da7>{:snd_pcm:snd_pcm_mmap_data_close+7}
RSP: 0018:ffff810017149ed0  EFLAGS: 00010286
RAX: 00002aaaaab2f000 RBX: ffff81001cb2ed08 RCX: ffff810017646b18
RDX: ffff810017646b18 RSI: ffff81001841ead8 RDI: ffff81001841ea88
RBP: ffff81001841ea88 R08: ffff81001cb2ed28 R09: ffff810017149ec8
R10: ffffffffffffffff R11: 0000000000000202 R12: ffff81001cb2ed48
R13: ffff810017dc9418 R14: ffff81003b31e0b8 R15: 00002aaaaab3f000
FS:  00002aaaad039de0(0000) GS:ffffffff8054e840(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aaaaab2f098 CR3: 0000000038f5d000 CR4: 00000000000006e0
Process artsd (pid: 4201, threadinfo ffff810017148000, task ffff810017616810)
Stack: ffffffff801705ea 00002aaaaab2f000 0000000000000000 0000000000000000 
       ffff81003b31e0b0 ffff81001841ea88 ffffffff801718c6 ffff81001841e9b8 
       ffff81001841e9d0 ffff81001841e9b8 
Call Trace:<ffffffff801705ea>{remove_vm_struct+106} <ffffffff801718c6>{do_munmap+550}
       <ffffffff8017194d>{sys_munmap+77} <ffffffff8010dc6e>{system_call+126}
       

Code: 48 8b 80 98 00 00 00 f0 ff 88 08 01 00 00 c3 66 66 66 90 66 
RIP <ffffffff880b5da7>{:snd_pcm:snd_pcm_mmap_data_close+7} RSP <ffff810017149ed0>
CR2: 00002aaaaab2f098
 

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
