Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752502AbWAGCvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbWAGCvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWAGCvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:51:53 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:14732 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752502AbWAGCvv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:51:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bnac8SlxrAc5ooJfXot+pAnpIp1Rwx3b1HciWoPW7pH10F6T4djXeXjJZZSdaJMyJJf3D/r3Khlmo/Fyt+GgtkNgQoKeWUs5uSdxfcSB6fqKpJfSBPNJI8tgjcTkuaufvU15hdkXknpSZ/D0/wG48lyaOJb8018Rqzi74ml6o0w=
Message-ID: <9a8748490601061851p7ecfab9fua866fc2a79153b0@mail.gmail.com>
Date: Sat, 7 Jan 2006 03:51:48 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, davej@codemonkey.org.uk, airlied@linux.ie
In-Reply-To: <20060106164012.041e14b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
	 <20060105162714.6ad6d374.akpm@osdl.org>
	 <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com>
	 <20060105165946.1768f3d5.akpm@osdl.org>
	 <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com>
	 <20060107002833.GB9402@redhat.com>
	 <20060106164012.041e14b2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/06, Andrew Morton <akpm@osdl.org> wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > On Sat, Jan 07, 2006 at 01:25:22AM +0100, Jesper Juhl wrote:
> >  > On 1/6/06, Andrew Morton <akpm@osdl.org> wrote:
> >  > > Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >  > >
> >  > > >  Reverted that one patch, then rebuild/reinstalled the kernel
> >  > > >  (with the same .config) and booted it - no change. It still locks up
> >  > > >  in the exact same spot.
> >  > > >  X starts & runs fine (sort of) since I can play around at the kdm
> >  > > >  login screen all I want, it's only once I actually login and KDE
> >  > > >  proper starts that it locks up.
> >  > >
> >  > > Oh bugger.  No serial console/netconsole or such?
> >  > >
> >  > > Or are you able log in and then quickly do the alt-ctrl-F1 thing, see if we
> >  > > get an oops?
> >  > >
> >  > I switched to tty1 right after logging in, and after a few seconds
> >  > (corresponding pretty well with the time it takes to hit the same spot
> >  > where it crashed all previous times) I got a lot of nice crash info
> >  > scrolling by.
> >  > Actually a *lot* scrolled by, a rough guestimate says some 4-6 (maybe
> >  > more) screens scrolled by, and since the box locks up solid I couldn't
> >  > scroll up to get at the initial parts :(  So all I have for you is the
> >  > final block - hand copied from the screen using pen and paper
> >  > ...
> >  > It never makes it to the logs, and as mentioned previously I don't
> >  > have another machine to capture on via netconsole or serial, so if you
> >  > have any good ideas as to how to capture it all, then I'm all ears.
> >
> > If only someone did a patch to pause the text output after the first oops..
> >
> > Oh wait! Someone did!
> >
>
> umm, it'd be more helpful if you'd actually sent the patch so Jesper could
> apply it so we can find this bug.
>

Ok, this is with a pristine 2.6.15-mm1 + Dave's oops-pausing-patch
Captured by switching to tty1 just after logging in via kdm.
A *lot* of info still scrolls down when the problem hits before Daves
patch stops it at a BUG dump, it scrolls by too fast for me to see
what it is, but I guess it must be warning/error messages other than
Oops's or BUG()'s ???

Anyway, here's the entire contents of my screen after Daves patch
stops the output - again written down by hand and then typed in from
my handwritten notes, so there may be typos, but I've tried to be
accurate.


050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
------------{ cut here ]------------
kernel BUG at include/linux/list.h:166!
invalid opcode: 0000 [#1]
PREEMPT SMP
Last sysfs file: /class/vc/vcsa2/dev
Modules linked in: snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec
snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc
snd_util_mem snd_hwdep snd agpgart
CPU:    0
EIP:    0060:[<c01475f5>]    Tainted: G    B VLI
EFLAGS: 00010017    (2.6.15-mm1)
EIP is at __rmqueue+0xe5/0x100
eax: c0374dd4 ebx: c16ea018 ecx: 00000007 edx: c16ef018
esi: c0374e9c edi: c0374d80 ebp: f7ad0dac esp: f7ad0d90
ds: 007b es: 007b ss: 0068
Process syslogd (pid: 1038, threadinfo=f7ad0000 task=c21dfa90)
Stack: <0>00000001 c16ef000 c0374e9c 00000000 00000000 c0374dcc
0000001f f7ad0dcc
       <0>c0147642 c0374e40 00000000 c0374d80 c0374d80 c0374d80
c0374dc0 f7ad0e00
       <0>c0147b1a c0374dcc c0179682 c21ce4d0 f7af1090 00000000
f7ad0f34 00000256
Call Trace:
 [<c0103e4a>] show_stack+0x8a/0xa0
 [<c0104060>] show_registers+0x1e0/0x250
 [<c0104272>] die+0x112/0x1a0
 [<c010437f>] do_trap+0x7f/0xc0
 [<c0104693>] do_invalid_op+0xa3/0xb0
 [<c0103b0b>] error_code+0x4f/0x54
 [<c0147642>] rmqueue_bulk+0x32/0x60
 [<c0147b1a>] buffered_rmqueue+0x12a/0x270
 [<c0147db3>] get_page_from_freelist+0xa3/0xd0
 [<c0147e2e>] __alloc_pages+0x4e/0x320
 [<c015e00b>] kmem_getpages+0x3b/0xa0
 [<c015eee2>] cache_grow+0xb2/0x170
 [<c015f1a8>] cache_alloc_refill+0x208/0x250
 [<c015f426>] kmem_cache_alloc+0x66/0x70
 [<c011dc6b>] dup_task_struct+0x3b/0xf0
 [<c011ea22>] copy_process+0x62/0xe70
 [<c011f922>] do_fork+0x62/0x1a0
 [<c0101b5f>] sys_clone+0x2f/0x40
 [<c0103009>] syscall_call+0x7/0xb
Code: 13 89 5a 04 ff 43 08 89 70 0c 0f ba 28 0b 3b 75 f0 7f d3 8b 45
e8 83 c4 10 5b 5e 5f c9 c3 0f 0b a5 00 91 bd 32 c0 e9 7a ff ff ff <0f>
0b a6 00 91 bd 32 c0 e9 74 ff ff ff 8d b4 26 00 00 00 00 8d


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
