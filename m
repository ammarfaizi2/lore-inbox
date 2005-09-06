Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVIFDlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVIFDlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 23:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVIFDlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 23:41:05 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:49088 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751310AbVIFDlE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 23:41:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XgdptNQXs3AHfOEiya4ki/zgMh1OtDd/KfSljcxfRS25/g8Rg5X7cdmiJzWvBMTP6jQMChLZj4s5ylFNLMEDNtYxDW3MjxEomkSL2R3RR+m6WqffYUQw8P2Um2qHhatil2pvjic1/oqd4ui1JBJ0pmfvqUEEZeqwlsjiA5EcFUQ=
Message-ID: <dda83e7805090520407aefb4d1@mail.gmail.com>
Date: Mon, 5 Sep 2005 20:40:53 -0700
From: Bret Towe <magnade@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: nfs4 client bug
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <9a87484905090513481118e67b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e78050903171516948181@mail.gmail.com>
	 <dda83e7805090320053b03615d@mail.gmail.com>
	 <20050904103523.GA5613@electric-eye.fr.zoreil.com>
	 <dda83e78050904124454fc675a@mail.gmail.com>
	 <dda83e78050904135113b95c4a@mail.gmail.com>
	 <20050904215219.GA9812@fieldses.org>
	 <dda83e780509042008294fbe26@mail.gmail.com>
	 <20050905031825.GA22209@fieldses.org>
	 <dda83e78050905134420f06fbf@mail.gmail.com>
	 <9a87484905090513481118e67b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 9/5/05, Bret Towe <magnade@gmail.com> wrote:
> > On 9/4/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > On Sun, Sep 04, 2005 at 08:08:22PM -0700, Bret Towe wrote:
> > > > On 9/4/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > > > Do you get anything from alt-sysrq-T?
> > > >
> > > > no i havent used that im usally in x when its freezing
> > > > x wont even switch to console would it still give me anything then?
> > >
> > > Well, you can try something like:
> > >         alt-sysrq-T
> > > wait a couple seconds, then
> > >         alt-sysrq-S
> > >         alt-sysrq-U
> > >         alt-sysrq-B
> > > with maybe a second between each to give stuff a chance to get to disk.
> > >
> > > Then if you're lucky you may find the stack dumps in your log after you
> > > reboot.
> >
> > tried it and so far no luck ill keep trying a few more times and see
> > if i can get it
> > to spit somethin out to disk but i dont think ill be that lucky as that would
> > prob make life to easy wouldnt it?
> 
> How about
> 
> serial console over a cross-over cable to a second box.
> netconsole will let you put the console on a different box over the network.
> console on line printer will let you have a permanent record of the
> console output on paper.
> 
> See
>  Documentation/serial-console.txt
>  Documentation/networking/netconsole.txt
>  the help entry for "config LP_CONSOLE" (in drivers/char/Kconfig)
> 
> Would any of those perhaps help you in capturing anything ?

netconsole++ 

got the following and ill be watching for anything that looks different
as i continue to push my luck

NMI Watchdog detected LOCKUP on CPU0CPU 0
Modules linked in: netconsole snd_seq_midi snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_emu10k1
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd w83627hf i2c_sensor i2c_isa
i2c_core usb_storage r8169 ehci_hcd uhci_hcd dm_mirror dm_snapshot
dm_mod
Pid: 14169, comm: xmms Tainted: G   M  2.6.13
RIP: 0010:[<ffffffff80158d3b>] <ffffffff80158d3b>{cache_alloc_refill+347}
RSP: 0018:ffff81001306fa48  EFLAGS: 00000017
RAX: ffff81002f995c90 RBX: ffff81002f994800 RCX: ffff81000a8a9000
RDX: ffff81002f995c90 RSI: 000000000000000e RDI: ffff810005cfc028
RBP: ffff81002f995c80 R08: ffff81002f994810 R09: ffff81002f995ca0
R10: ffff81002f995cb0 R11: ffffffff80154a40 R12: ffff81002f995c90
R13: ffff81002f98d5c0 R14: 00000000000000d0 R15: ffffffff801e1550
FS:  0000000041802960(0063) GS:ffffffff805bc800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaab351000 CR3: 00000000297c8000 CR4: 00000000000006e0
Process xmms (pid: 14169, threadinfo ffff81001306e000, task ffff81001beae0b0)
Stack: ffff81002fb0f1c0 0000000000000000 ffff81001306faa8 00000000000000d0
       ffff81002f995c80 ffff81002d450400 ffff81001306fb18 ffff810001bb2078
       ffffffff801e1550 ffffffff80158a7d
Call Trace:<ffffffff801e1550>{nfs_find_actor+0}
<ffffffff80158a7d>{kmem_cache_alloc+77}
       <ffffffff801e4305>{nfs_alloc_inode+21} <ffffffff80187fc2>{alloc_inode+18}
       <ffffffff80188e48>{iget5_locked+200}
<ffffffff801e15c0>{nfs_init_locked+0}
       <ffffffff801e191e>{nfs_fhget+110} <ffffffff801de5f5>{nfs_lookup+309}
       <ffffffff801eede7>{_nfs4_proc_access+215}
<ffffffff8017d235>{do_lookup+229}
       <ffffffff8017d801>{__link_path_walk+849}
<ffffffff8017e2aa>{link_path_walk+186}
       <ffffffff8016f668>{get_unused_fd+88} <ffffffff8017e521>{path_lookup+385}
       <ffffffff8017ed6f>{open_namei+175} <ffffffff8012d6e4>{deactivate_task+20}
       <ffffffff8016f5e7>{filp_open+39} <ffffffff8016f668>{get_unused_fd+88}
       <ffffffff8016f7b4>{sys_open+84} <ffffffff8010e8b6>{system_call+126}


Code: 4c 89 61 08 49 89 0c 24 85 f6 0f 8f 3c ff ff ff 8b 3b 89 f8
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 <6>SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 000000010001d013     0     1      0     2               (NOTLB)
ffff810001c61d88 0000000000000082 0000000000000000 ffffffff8048c4b8
       ffff81001beaee10 ffff810001c5f440 ffff81001beaee10 ffff810001c5f658
       ffff810001c5f440 0000001001c61e68
Call Trace:<ffffffff803a5744>{schedule_timeout+148}
<ffffffff80139a30>{process_timeout+0}
       <ffffffff8017c052>{pipe_poll+66} <ffffffff80182d77>{do_select+967}
       <ffffffff801828c0>{__pollwait+0} <ffffffff801830bc>{sys_select+748}
       <ffffffff8010e8b6>{system_call+126}
ksoftirqd/0   S 0000000000000000     0     2      1             3       (L-TLB)
ffff810001c65f08 0000000000000046 ffff810001c65f18 ffff81002c8102b0
       ffff810026a85110 ffff810001c5ed90 ffff810026a85110 ffff810001c5efa8
       ffff810001c5f440 ffff810001c65f08
Call Trace:<ffffffff80135e60>{ksoftirqd+0} <ffffffff80135ea5>{ksoftirqd+69}
       <ffffffff80135e60>{ksoftirqd+0} <ffffffff8014424d>{kthread+205}
       <ffffffff8010f3e6>{child_rip+8} <ffffffff80144180>{kthread+0}
       <ffffffff8010f3de>{child_rip+0}
events/0      R  running task       0     3      1             4     2 (L-TLB)
khelper       S ffff810001c3b300     0     4      1             5     3 (L-TLB)
ffff810001ef9e78 0000000000000046 0000000000000000 ffffffff80140040
       ffff81002fbd0e90 ffff810001c5e030 ffff81002fbd0e90 ffff810001c5e248
       ffff810001c3b330 ffff810001c3b320
Call Trace:<ffffffff80140040>{__call_usermodehelper+0}
<ffffffff801403c6>{worker_thread+278}
       <ffffffff8012e060>{default_wake_function+0}
<ffffffff8012e060>{default_wake_function+0}
       <ffffffff801402b0>{worker_thread+0} <ffffffff8014424d>{kthread+205}
       <ffffffff8010f3e6>{child_rip+8} <ffffffff80144180>{kthread+0}
       <ffffffff8010f3de>{child_rip+0}
kthread       S ffff810001ec3300     0     5      1     7     147     4 (L-TLB)
ffff810001f1de78 0000000000000046 0000000000000000 ffff81002f9d5d28
       ffff81002f9d34c0 ffff810001f1b480 ffff81002f9d34c0 ffff810001f1b698
       ffff810001ec3330 ffff810001ec3320
Call Trace:<ffffffff801403c6>{worker_thread+278}
<ffffffff8012e060>{default_wake_function+0}
       <ffffffff8012e060>{default_wake_function+0}
<ffffffff801402b0>{worker_thread+0}
       <ffffffff8014424d>{kthread+205} <ffffffff8010f3e6>{child_rip+8}
       <ffffffff80144180>{kthread+0} <ffffffff8010f3de>{child_rip+0}

kacpid        S ffff810001ec30c0     0     7      5            90       (L-TLB)
ffff81002f911e78 0000000000000046 403b0520522700f8 604000005101c501
       ffff810001c5f440 ffff810001f1add0 ffff810001c5f440 ffff810001f1afe8
       c408018023918081 0000000000010000
