Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319609AbSIHNcc>; Sun, 8 Sep 2002 09:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319610AbSIHNcc>; Sun, 8 Sep 2002 09:32:32 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52692 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S319609AbSIHNca> convert rfc822-to-8bit; Sun, 8 Sep 2002 09:32:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: Alan Cox <alan@redhat.com>, bunk@fs.tum.de (Adrian Bunk)
Subject: Re: Linux 2.4.20-pre5-ac4
Date: Sun, 8 Sep 2002 15:36:57 +0200
User-Agent: KMail/1.4.2
Cc: alexh@ihatent.com (Alexander Hoogerhuis), linux-kernel@vger.kernel.org
References: <200209081255.g88CtHJ31280@devserv.devel.redhat.com>
In-Reply-To: <200209081255.g88CtHJ31280@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209081536.58017.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 September 2002 14:55, Alan Cox wrote:
> > Which non-free modues (NVidia?) were loaded on your computer? Is the
> > problem reproducible without any non-free module loaded _ever_ since the
> > last reboot?
>
> I've seen this trace without nvidia etc loaded too. Right now the problem
> I have is that I can't duplicate it. If my box would jut blow up the same
> way all would be well 8)

just for reference, here's mine untainted:

ksymoops 2.4.6 on i686 2.4.20-pre5-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre5-ac4/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol 
DAC1064_global_init_R__ver_DAC1064_global_init not found in System.map.  
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol 
DAC1064_global_restore_R__ver_DAC1064_global_restore not found in System.map.  
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol matrox_G100_R__ver_matrox_G100 not 
found in System.map.  Ignoring ksyms_base entry
Sep  8 15:05:45 elfe kernel: kernel BUG at 
/usr/src/linux/include/linux/blkdev.h:153!
Sep  8 15:05:45 elfe kernel: invalid operand: 0000
Sep  8 15:05:45 elfe kernel: CPU:    0
Sep  8 15:05:45 elfe kernel: EIP:    0010:[ide_build_sglist+73/384]    Not 
tainted
Sep  8 15:05:45 elfe kernel: EFLAGS: 00010206
Sep  8 15:05:45 elfe kernel: eax: 0000005a   ebx: effc9000   ecx: c02c73c0   
edx: eaf1aec0
Sep  8 15:05:45 elfe kernel: esi: 00000000   edi: eaf1aec0   ebp: e04dbba0   
esp: e04dbb80
Sep  8 15:05:45 elfe kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 15:05:45 elfe kernel: Process mount (pid: 1229, stackpage=e04db000)
Sep  8 15:05:45 elfe kernel: Stack: effc9000 c02c7470 eaf1aec0 e23b1280 
00000003 0000000d c02c7470 c19f6000 
Sep  8 15:05:45 elfe kernel:        e04dbbcc c019c4a1 c02c73c0 eaf1aec0 
c02c73c0 c02c7470 eaf1aec0 ef57d140 
Sep  8 15:05:45 elfe kernel:        00000000 00000000 c02c73c0 e04dbbec 
c019c97a c02c7470 eaf1aec0 c02c7470 
Sep  8 15:05:45 elfe kernel: Call Trace:    [ide_build_dmatable+81/400] 
[__ide_dma_read+42/288] [nfsd:__insmod_nfsd_O/lib/m
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; effc9000 <_end+2fcf46a4/325316a4>
>>ecx; c02c73c0 <ide_hwifs+0/2c88>
>>edx; eaf1aec0 <_end+2ac46564/325316a4>
>>edi; eaf1aec0 <_end+2ac46564/325316a4>
>>ebp; e04dbba0 <_end+20207244/325316a4>
>>esp; e04dbb80 <_end+20207224/325316a4>

Sep  8 15:05:45 elfe kernel:   [<f29ea1b1>] [<f29e658f>] [<f29e7b6e>] 
[<f29e8446>] [<f29eccce>] [<f29ec459>]
Sep  8 15:05:45 elfe kernel:   [<f29ec451>] [<f29ecca8>] [get_sb_bdev+438/544] 
[<f29ed700>] [<f29ed700>] [alloc_vfsmnt+137/
Sep  8 15:05:45 elfe kernel: Code: 0f 0b 99 00 a0 b8 22 c0 8b 45 08 c7 80 24 
04 00 00 01 00 00 
Using defaults from ksymoops -t elf32-i386 -a i386


Trace; f29ea1b1 <END_OF_CODE+c1da/????>
Trace; f29e658f <END_OF_CODE+85b8/????>
Trace; f29e7b6e <END_OF_CODE+9b97/????>
Trace; f29e8446 <END_OF_CODE+a46f/????>
Trace; f29eccce <END_OF_CODE+ecf7/????>
Trace; f29ec459 <END_OF_CODE+e482/????>
Trace; f29ec451 <END_OF_CODE+e47a/????>
Trace; f29ecca8 <END_OF_CODE+ecd1/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   99                        cltd   
Code;  00000003 Before first symbol
   3:   00 a0 b8 22 c0 8b         add    %ah,0x8bc022b8(%eax)
Code;  00000009 Before first symbol
   9:   45                        inc    %ebp
Code;  0000000a Before first symbol
   a:   08 c7                     or     %al,%bh
Code;  0000000c Before first symbol
   c:   80 24 04 00               andb   $0x0,(%esp,%eax,1)
Code;  00000010 Before first symbol
  10:   00 01                     add    %al,(%ecx)


4 warnings issued.  Results may not be reliable.

> What compilers are being used by the folks who see the problem ?

Linux elfe 2.4.20-pre5-ac4 #4 Sam Sep 7 20:49:05 CEST 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.2a1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11b
modutils               2.4.20
e2fsprogs              1.19
reiserfsprogs          3.x.1b
PPP                    2.4.1
isdn4k-utils           3.1pre2
Linux C Library         Nov 2001  /lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         sr_mod cdrom snd-pcm-oss snd-mixer-oss tuner tvaudio 
msp3400 bttv i2c-algo-bit videodev printer scanner usb-uhci usbcore 
nls_iso8859-1 isofs zlib_inflate w83781d i2c-proc i2c-viapro i2c-core autofs 
serial isa-pnp parport_pc lp parport snd-seq-midi snd-seq-oss 
snd-synth-emu10k1 snd-synth-emux snd-seq-midi-emul snd-seq-virmidi 
snd-seq-midi-event snd-seq snd-card-emu10k1 snd-emu10k1 snd-rawmidi snd-pcm 
snd-timer snd-util-mem snd-ac97-codec snd-hwdep snd-seq-device snd soundcore 
nfsd ide-disk ide-scsi scsi_mod agpgart

glibc is a 2.2.4, base is a SuSE 7.3.

Rest of my former oops report still applies.

Let me hear, if I can do something more.

Hans-Peter
