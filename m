Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUEUXmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUEUXmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbUEUXkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:40:55 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:9102 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265114AbUEUXXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:23:19 -0400
Message-ID: <1144.128.150.143.219.1085152432.squirrel@webmail.seven4sky.com>
In-Reply-To: <45437.192.168.1.1.1085022956.squirrel@webmail.seven4sky.com>
References: <45437.192.168.1.1.1085022956.squirrel@webmail.seven4sky.com>
Date: Fri, 21 May 2004 11:13:52 -0400 (EDT)
Subject: Re: PROBLEM: Linux 2.6.6 completely locked up. : kernel BUG at     
      fs/buffer.c
From: "Sam Gill" <samg@seven4sky.com>
To: "John Rimell" <john@rimell.cc>, linux-kernel@vger.kernel.org
Reply-To: samg@seven4sky.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 John,


>> module-init-tools      2.4.26

 may need to be updated to the 2.6.x series compatible version.

 Also growisofs -R -J -Z /dev/hdd
 is a disc-at-once command.

 If you have memory or I/O problems or
 a bottleneck anywhere in between, you should not use this method.

 In fact burning the dvd may require _all_ cpu, and
 you are better off leaving the cpu, not doing anything else
 while it is burning.

 The better method, that is a little easier for growisofs to handle
 is to make an image with
 mkisofs first, and then use growisofs
 like: growisofs -Z /dev/hdd=myimage

 do: man mkisofs,
 and it lists how to get our of 8.3 formats

 hope this helps,
  -sam






>> I've been running linux for years and not seen it lock up like this
>> before. It stopped responding to all input. I was in X and mouse froze,
>> it stopped responding to all keyboard input including Ctl-alt-F1/2/3/4
>> etc and Ctl-atl-Del. I could ping the box from another machine but not
>> ssh in.
>>
>> On Redhat 9 updated with a lot of fedora core 2 bits, I was running X
>> using Gnome 2.6 and commands were inputted using gnome-terminal.
>> It all revolved around using growisofs of dvd+rw-tools-5.17.4.8.6-2. I
>> have a Ricoh MP5125A that I recently installed and is allocated /dev/hdc
>> (with symbolic link /dev/dvd pointing to it)
>> I have just started trying to write to it using growisofs.
>> It worked the first time using the command growisofs -Z /dev/dvd <files>
>> But I noticed that the filenames were getting changed to a 8.3 format,
>> so I tried again using... growisofs -J -R -Z /dev/dvd
>> That failed and returned an error message that I don't remember and
>> wasn't logged :(
>>  From that point on, the light on the front of the DVD drive was lit up
>> as if it was in use.
>> The drive refused to eject as if the drive was mounted, but it was not
>> and umount simply would say the drive was not mounted (I don't really
>> think it was).
>> I tried to mount the drive but mount seg faulted!
>> In a last attempt to get something to communicate with the drive I tried
>> a growisofs -M /dev/dvd <files>  (try to add more files to the disc)
>> At that point, linux crashed. complete system freeze. The screen stayed
>> the same, but the mouse was frozen along with everything else.
>>
>> Now for the good news. I got a load of log data in my /var/log/messages.
>> I can't be clear as to what command caused what messages, but ignore all
>> the smartd stuff on the other drive.
>>
>>
>> May 19 18:29:38 fred kernel: UDF-fs: No VRS found
>> May 19 18:37:23 fred kernel: hdc: DMA timeout retry
>> May 19 18:37:23 fred kernel: hdc: timeout waiting for DMA
>> May 19 18:37:23 fred kernel: hdc: status timeout: status=0xd0 { Busy }
>> May 19 18:37:23 fred kernel: hdc: status timeout: error=0x00
>> May 19 18:37:23 fred kernel: hdc: drive not ready for command
>> May 19 18:37:23 fred kernel: hdc: ATAPI reset complete
>> May 19 18:37:31 fred kernel: hdc: status error: status=0x58 { DriveReady
>> SeekComplete DataRequest }
>> May 19 18:37:31 fred kernel: hdc: status error: error=0x00
>> May 19 18:37:31 fred kernel: hdc: drive not ready for command
>> May 19 18:37:31 fred kernel: hdc: status error: status=0x58 { DriveReady
>> SeekComplete DataRequest }
>> May 19 18:37:31 fred kernel: hdc: status error: error=0x00
>> May 19 18:37:31 fred kernel: hdc: drive not ready for command
>> May 19 18:37:31 fred kernel: hdc: status error: status=0x58 { DriveReady
>> SeekComplete DataRequest }
>> May 19 18:37:31 fred kernel: hdc: status error: error=0x00
>> May 19 18:37:31 fred kernel: hdc: drive not ready for command
>> May 19 18:37:31 fred kernel: hdc: status error: status=0x58 { DriveReady
>> SeekComplete DataRequest }
>> May 19 18:37:31 fred kernel: hdc: status error: error=0x00
>> May 19 18:37:31 fred kernel: hdc: DMA disabled
>> May 19 18:37:31 fred kernel: hdc: drive not ready for command
>> May 19 18:38:01 fred kernel: hdc: ATAPI reset timed-out, status=0xd8
>> May 19 18:38:36 fred kernel: ide1: reset timed-out, status=0xd8
>> May 19 18:38:36 fred kernel: hdc: status timeout: status=0xd8 { Busy }
>> May 19 18:38:36 fred kernel: hdc: status timeout: error=0x00
>> May 19 18:38:36 fred kernel: hdc: drive not ready for command
>> May 19 18:39:06 fred kernel: hdc: ATAPI reset timed-out, status=0xd8
>> May 19 18:39:36 fred kernel: ide1: reset timed-out, status=0xd8
>> May 19 18:44:09 fred su(pam_unix)[3397]: session opened for user root by
>> jjrimell(uid=500)
>> May 19 18:44:18 fred su(pam_unix)[3397]: session closed for user root
>> May 19 18:44:38 fred smartd[1364]: Device: /dev/hdi, FAILED SMART
>> self-check. BACK UP DATA NOW!
>> May 19 18:44:39 fred kernel: [fglrx:firegl_agp_lock_pages] *ERROR*
>> agp_allocate_memory_phys_list failed
>> May 19 19:14:39 fred smartd[1364]: Device: /dev/hdi, FAILED SMART
>> self-check. BACK UP DATA NOW!
>> May 19 19:14:39 fred smartd[1364]: Device: /dev/hdi, SMART Prefailure
>> Attribute: 8 Seek_Time_Performance changed from 253 to 252
>> May 19 19:40:40 fred su(pam_unix)[7338]: session opened for user root by
>> jjrimell(uid=500)
>> May 19 19:44:38 fred smartd[1364]: Device: /dev/hdi, FAILED SMART
>> self-check. BACK UP DATA NOW!
>> May 19 19:44:38 fred smartd[1364]: Device: /dev/hdi, SMART Prefailure
>> Attribute: 8 Seek_Time_Performance changed from 252 to 253
>> May 19 19:47:50 fred kernel: udf: bad block size (2048)
>> May 19 19:47:50 fred kernel: ------------[ cut here ]------------
>> May 19 19:47:50 fred kernel: kernel BUG at fs/buffer.c:1214!
>> May 19 19:47:50 fred kernel: invalid operand: 0000 [#1]
>> May 19 19:47:50 fred kernel: PREEMPT DEBUG_PAGEALLOC
>> May 19 19:47:50 fred kernel: CPU:    0
>> May 19 19:47:50 fred kernel: EIP:    0060:[<c0172609>]    Tainted: P
>> May 19 19:47:50 fred kernel: EFLAGS: 00010286   (2.6.6)
>> May 19 19:47:50 fred kernel: EIP is at __getblk_slow+0x69/0x100
>> May 19 19:47:50 fred kernel: eax: fffffe00   ebx: 00000000   ecx:
>> 0000ec00   edx: 0000ec00
>> May 19 19:47:50 fred kernel: esi: 00000000   edi: e5afbda4   ebp:
>> 00008000   esp: cfecddc0
>> May 19 19:47:50 fred kernel: ds: 007b   es: 007b   ss: 0068
>> May 19 19:47:50 fred kernel: Process mount (pid: 7499,
>> threadinfo=cfecc000 task=ea61fa10)
>> May 19 19:47:50 fred kernel: Stack: e5afbda4 00008000 00000000 00000000
>> 00000000 00008000 e5afbda4 00000000
>> May 19 19:47:50 fred kernel:        c0172b4f e5afbda4 00008000 00000000
>> 00000010 00008000 db8e8294 c0172bdf
>> May 19 19:47:50 fred kernel:        e5afbda4 00008000 00000000 c01d5089
>> e5afbda4 00008000 00000000 c017625d
>> May 19 19:47:50 fred kernel: Call Trace:
>> May 19 19:47:50 fred kernel:  [<c0172b4f>] __getblk+0x4f/0x60
>> May 19 19:47:50 fred kernel:  [<c0172bdf>] __bread+0x1f/0x40
>> May 19 19:47:50 fred kernel:  [<c01d5089>] isofs_fill_super+0x159/0x700
>> May 19 19:47:50 fred kernel:  [<c017625d>] alloc_super+0x1d/0x3b0
>> May 19 19:47:50 fred kernel:  [<c0179835>] sb_set_blocksize+0x25/0x60
>> May 19 19:47:50 fred kernel:  [<c017921d>] get_sb_bdev+0x11d/0x150
>> May 19 19:47:50 fred kernel:  [<c01d643f>] isofs_get_sb+0x2f/0x70
>> May 19 19:47:50 fred kernel:  [<c01d4f30>] isofs_fill_super+0x0/0x700
>> May 19 19:47:50 fred kernel:  [<c017946f>] do_kern_mount+0x5f/0xe0
>> May 19 19:47:50 fred kernel:  [<c019ba58>] do_add_mount+0x78/0x170
>> May 19 19:47:50 fred kernel:  [<c019bd54>] do_mount+0x144/0x190
>> May 19 19:47:50 fred kernel:  [<c019bbb3>] copy_mount_options+0x63/0xc0
>> May 19 19:47:50 fred kernel:  [<c019c325>] sys_mount+0x125/0x280
>> May 19 19:47:50 fred kernel:  [<c01049e5>] sysenter_past_esp+0x52/0x71
>> May 19 19:47:50 fred kernel:
>> May 19 19:47:50 fred kernel: Code: 0f 0b be 04 4e 15 39 c0 b9 ff ff ff
>> ff 41 89 f0 d3 e0 3d ff
>> May 19 19:48:34 fred su(pam_unix)[7536]: session opened for user root by
>> jjrimell(uid=500)
>> May 19 19:59:53 fred syslogd 1.4.1: restart.
>>
>>
>>
>> [root@fred scripts]# ./ver_linux
>> If some fields are empty or look unusual you may have an old version.
>> Compare to the current minimal requirements in Documentation/Changes.
>>
>> Linux fred.earthlink.net 2.6.6 #2 Wed May 19 19:06:24 EDT 2004 i686
>> athlon i386 GNU/Linux
>>
>> Gnu C                  3.3.3
>> Gnu make               3.80
>> binutils               2.15.90.0.3
>> util-linux             2.11y
>> mount                  2.11y
>> module-init-tools      2.4.26
>> e2fsprogs              1.35
>> jfsutils               1.0.17
>> reiserfsprogs          3.6.4
>> pcmcia-cs              3.1.31
>> quota-tools            3.06.
>> PPP                    2.4.1
>> isdn4k-utils           3.1pre4
>> nfs-utils              1.0.1
>> Linux C Library        2.3.3
>> Dynamic linker (ldd)   2.3.3
>> Procps                 2.0.11
>> Net-tools              1.60
>> Kbd                    1.08
>> Sh-utils               5.2.1
>> Modules Loaded         snd_pcm_oss snd_mixer_oss binfmt_misc
>> snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi
>> snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi
>> snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc
>> snd_util_mem snd_hwdep snd soundcore ipv6 autofs parport_pc parport
>> nls_iso8859_1
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>

