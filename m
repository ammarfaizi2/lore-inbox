Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSFEVeC>; Wed, 5 Jun 2002 17:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSFEVeB>; Wed, 5 Jun 2002 17:34:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54146 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315746AbSFEVd5>; Wed, 5 Jun 2002 17:33:57 -0400
Date: Wed, 5 Jun 2002 17:37:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Oliver Wegner <oliver@wilmskamp.dyndns.org>
cc: Eric Kristopher Sandall <sandalle@wsunix.wsu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
In-Reply-To: <200206052257.15492.oliver@wilmskamp.dyndns.org>
Message-ID: <Pine.LNX.3.95.1020605172819.12226A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Oliver Wegner wrote:

> Am Mittwoch, 5. Juni 2002 21:08 schrieb Eric Kristopher Sandall:
> > On Wed, 5 Jun 2002, John Tyner wrote:
> > > > Just put the module name in /etc/modules
> > >
> > > This is distribution dependent isn't it?
> >
> > afaik, it is not distro dependent.  I've used /etc/modules in RedHat,
> > Debian, Sorcery, Source Mage, and Mandrake, all to the same effect.
> 
> well, i havent found that file /etc/modules in SuSE. am not aware right now 
> how they handle loading modules during boot process... ;)
> 
> Oliver
> 

This is getting "tired". I told you how to find out this information.

Here is a SuSE distribution's /etc/modules.conf, complete with its
copyright notice. You need to know that Linux uses a strange command
interpreter that, unlike windows, does not know how to read one's
mind. This means that, should you enter, for instance, `ls /etc/modules`,
it isn't going to find it because it doesn't exist. You need to either
type its full name or use wild-cards which I won't explain here.

#
#
# Copyright (c) 1996-2000 SuSE GmbH Nuernberg, Germany.  All rights reserved.
#
# Author: Hubert Mantel <mantel@suse.de>, 1996-2000
#
# Configuration file for loadable modules; used by modprobe and kerneld
#
# Aliases - specify your hardware
alias eth1 off
alias tr0 off
alias scsi_hostadapter off
alias fb0 off
# only used for Mylex or Compaq Raid as module
alias block-major-48 off
alias block-major-49 off
alias block-major-72 off
alias block-major-73 off
# only needed for fifth and sixth IDE adaptor
alias block-major-56 off
alias block-major-57 off
# mouse (for older busmice)
alias char-major-10 off
alias parport_lowlevel parport_pc
options parport_pc io=0x378 irq=none,none
# If you have multiple parallel ports, specify them this way:
# options parport_pc io=0x378,0x278  irq=none,none
# For parallel port devices, uncomment the following two lines and change
# "frpw" to the protocol type you use
# post-install paride insmod frpw
# pre-remove paride rmmod frpw
#*****************************************************************************
# If you want to use the kernel sound drivers instead of OSS 3.8.1z (the 
# recommended solution) please put comment signs in front of the following 
# entries. Then choose one of the sample configurations below. Uncomment all
# lines starting with 'alias', 'options' or 'pre-/post-install' within one 
# such configuration and modify the parameters according to your needs (e.g. 
# the ressources chosen for this device in /etc/isapnp.conf). For a lot of 
# ISA soundcards the Soundblaster driver is a good starting point.
#*****************************************************************************
alias char-major-14 off
alias sound off
alias midi off
#*****************************************************************************
#    module : ad1816.o           AD1816 chip
#
#                                Supported cards :
#
#                                Terratec Base 1/64
#                                HP Kayak
#                                Acer FX-3D
#                                SY-1816
#                                Highscreen Sound-Boostar 32 Wave 3D
#                                Highscreen Sound-Boostar 16
#    
#    Documentation available in /usr/src/linux/Documentation/sound/AD1816
#    and in /usr/src/linux/drivers/sound/ad1816.c .
#
#    Possible configuration :
#
# alias char-major-14 ad1816
# post-install ad1816 modprobe "-k" opl3
# post-install ad1816 modprobe "-k" mpu401
# options ad1816 io=0x530 irq=5 dma=1 dma2=3 ad1816_clockfreq=33000
# options opl3 io=0x0388
# options mpu401 io=0x0330 irq=9      
#
#*****************************************************************************
#    module : ad1848.o           AD1848/CS4231/CS4248 Chip
#                                --> Windows Sound System (MSS/WSS)
#
#                                A variety of common ISA soundcards are
#                                compatible with this family of chips.
#
#    Documentation available in /usr/src/linux/drivers/sound/ad1848.c (search
#    for MODULE_PARM) and in /usr/src/linux/Documentation/sound/README.OSS .
#    Usually this module is used in conjunction with other higher level sound
#    modules.
#
#    Possible configuration for stand-alone usage :
#
# alias char-major-14 ad1848
# options ad1848 io=0x530 irq=7 dma=0 dma2=3
#
#*****************************************************************************
#    module : cs4232.o           Crystal 423x chipsets
#
#    Documentation available in /usr/src/linux/drivers/sound/cs4232.c (search
#    for MODULE_PARM) and in /usr/src/linux/Documentation/sound/CS4232 . This
#    chip is often used together with other sound hardware.
#
#    Possible configuration for stand-alone usage :
#
# alias char-major-14 cs4232
# post-install cs4232 modprobe "-k" opl3 
# options cs4232 io=0x534 irq=5 dma=1 dma2=0 mpuio=0x330 mpuirq=9
# options opl3 io=0x388
#
#*****************************************************************************
#    module : es1370.o           Ensoniq 1370 Chipsatz (--> PCI64/128)
#                                
#                                Supported cards :
#                                
#                                Creative Labs PCI64/128
# 
#    Documentation availabke at /usr/src/linux/Documentation/sound/es1370 and
#    /usr/src/linux/drivers/sound/es1370.c .
#
# alias char-major-14  es1370
# options es1370 joystick=1
#
#*****************************************************************************
#    module : es1371.o           Creative Ensoniq 1371 Chipsatz (--> PCI64/128)
#
#                                Supported cards :
#                                
#                                Creative Labs PCI64/128
#
#    Documentation availabke at /usr/src/linux/Documentation/sound/es1371 and
#    /usr/src/linux/drivers/sound/es1371.c . 
#
# alias char-major-14  es1371
# options es1371 joystick=0x200
#
#*****************************************************************************
#    module : mad16.o            MAD16
#
#    Possible configuration :
#
# alias char-major-14 mad16
# options sb mad16=1
# options mad16 io=0x530 irq=7 dma=0 dma16=1
#
#*****************************************************************************
#    module : sb.o               Soundblaster 16, SB Pro + Clones
#                                Also needed for AWE32/64 
#
#    Dcoumentation available in /usr/src/linux/Documentation/sound/Soundblaster
#    and in /usr/src/linux/drivers/sound/sb.c .
#
#    Possible configuration :
#
# alias char-major-14 sb
# post-install sb /sbin/modprobe "-k" "adlib_card"
# options sb io=0x220 irq=7 dma=1 dma16=5 mpu_io=0x330
# options adlib_card io=0x388
#
#*****************************************************************************
#    module : trix.o             MediaTrix AudioTrix Pro
#
# alias char-major-14 trix
# pre-install trix modprobe "-k" 
#
#*****************************************************************************
#    module : wavefront.o        Turtle Beach Maui, Tropez, Tropez Plus
#
#    Comment from /usr/src/linux/Documentation/sound/Wavefront :
#    (please read that file !)
#    "the wavefront options "io" and "irq" ***MUST*** match the "synthio"
#     and "synthirq" cs4232 options."
#
#    Possible configuration :
#
# alias char-major-14 wavefront
# alias synth0 wavefront
# alias mixer0 cs4232
# alias audio0 cs4232
# pre-install wavefront modprobe "-k" "cs4232"
# post-install wavefront modprobe "-k" "opl3"
# options wavefront io=0x200 irq=9
# options cs4232 synthirq=9 synthio=0x200 io=0x530 irq=5 dma=1 dma2=0
# options opl3 io=0x388 
#
#*****************************************************************************
#*****************************************************************************
# Example config for ALSA (for SB16 PnP - like cards)
# You don't need to run isapnp with ALSA, it has full PnP support.
# See /usr/doc/packages/alsa/README.SuSE
#*****************************************************************************
# 
#ALSA native device support:
#
# alias char-major-116 snd
# options snd snd_major=116 snd_cards_limit=1
#
#Insert your sound driver name here, and it you have a PCI or PnP card,
#you are ready to do "rcsalsactl start":
#
# alias snd-card-0 snd-card-sb16
#                  ^^^^^^^^^^^^^
# options snd-card-sb16 snd_index=0
#         ^^^^^^^^^^^^^
#
#For a list of supported soundcards look into /usr/src/packages/alsa/cards.txt
#
#OSS/Free emulation
#
# alias char-major-14 soundcore
# alias snd-slot-0  snd-card-0
# alias sound-service-0-0  snd-mixer-oss
# alias sound-service-0-1  snd-seq-oss
# alias sound-service-0-3  snd-pcm-oss
# alias sound-service-0-8  snd-seq-oss
# alias sound-service-0-12 snd-pcm-oss
#
#Set mixer to stored defaults (with alsactl store)
# post-install snd  alsactl restore
# 
#*****************************************************************************
########################################################################
# Options; these are examples; uncommented and modify the lines you need
########################################################################
# options cdu31a         cdu31a_port=0x340 cdu31a_irq=0
# options sbpcd          sbpcd=0x230,1
# options aztcd          aztcd=0x320
# options cm206          cm206=0x340,11
# options gscd           gscd=0x340
# options mcd            mcd=0x300,11
# options mcdx           mcdx=0x300,11
# options optcd          optcd=0x340
# options sjcd           sjcd_base=0x340
# options sonycd535      sonycd535=0x340
# options isp16          isp16_cdrom_base=0x340 isp16_cdrom_irq=0 isp16_cdrom_dma=0 isp16_cdrom_type=Sanyo
# options ne             io=0x300 irq=5
# Use this if you have two cards:
# options ne             io=0x300,0x320 irq=5,7
# options tulip          options=0
# options 3c59x          options=0
# options 3c501          io=0x280 irq=5
# options 3c503          io=0x280 irq=5 xcvr=0
# options 3c505          io=0x300 irq=10
# options 3c507          io=0x300 irq=10
# options 3c509          irq=10
# options at1700         io=0x260 irq=10
# options smc-ultra      io=0x200 irq=10
# options wd             io=0x300 irq=10
# options smc9194        io=0x200 irq=10 ifport=0
# options e2100          io=0x300 irq=10 mem=0xd0000 xcvr=0
# options depca          io=0x200 irq=7
# options ewrk3          io=0x300 irq=10
# options eexpress       io=0x300 irq=10
# options hp-plus        io=0x300 irq=10
# options hp             io=0x300 irq=10
# options hp100          hp100_port=0x380
# options apricot        io=0x300 irq=10
# options ac3200         io=0x300 irq=10 mem=0xd0000
# options de620          io=0x378 irq=7 bnc=1
# options ibmtr          io=0xa20
# options arcnet         io=0x300 irq=10 shmem=0xd0000
# options plip           io=0x378 irq=7
# options eepro          io=0x260 irq=10 mem=0x6000
# options eth16i         io=0x2a0 irq=10
# options fmv18x         io=0x220 irq=10
# options ni52           io=0x360 irq=9 memstart=0xd0000 memend=0xd4000
# options bttv           card=2
# options tuner          type=7
options dummy0 -o dummy0
options dummy1 -o dummy1
alias block-major-1 rd
alias block-major-2 floppy
alias block-major-3 off
alias block-major-7 loop
alias block-major-8 sd_mod
alias block-major-11 sr_mod
alias block-major-13 xd
alias block-major-15 cdu31a
alias block-major-16 gscd
alias block-major-17 optcd
alias block-major-18 sjcd
alias block-major-20 mcdx
alias block-major-22 off
alias block-major-23 mcd
alias block-major-24 sonycd535
alias block-major-25 sbpcd
alias block-major-26 sbpcd
alias block-major-27 sbpcd
alias block-major-28 sbpcd
alias block-major-29 aztcd
alias block-major-32 cm206
alias block-major-33 off
alias block-major-34 off
# network block device
alias block-major-43 off
alias block-major-45 pd
alias block-major-46 pcd
alias block-major-47 pf
alias char-major-4 serial
alias char-major-5 serial
alias char-major-6 lp
alias char-major-9 st
alias char-major-10-135 off
alias char-major-10-175 agpgart
alias char-major-10-240 agpgarti810
alias char-major-15 off
alias char-major-19 cyclades
alias char-major-20 cyclades
alias char-major-21 sg
alias char-major-27 ftape
# fb
alias char-major-29 off
alias char-major-30 iBCS
alias char-major-36 netlink_dev
# alias char-major-43       hisax
# alias char-major-44       hisax
# alias char-major-45       hisax
alias char-major-43 off
alias char-major-44 off
alias char-major-45 off
alias char-major-48 riscom8
alias char-major-49 riscom8
alias char-major-67 coda
alias char-major-75 specialix
alias char-major-76 specialix
alias char-major-81 bttv
alias char-major-83 vtx
options vtx quiet=1
alias char-major-89 i2c-dev
alias char-major-96 pt
alias char-major-97 pg
alias char-major-107 3dfx
alias char-major-108 ppp_async
alias char-major-109 lvm
# ppp over ethernet
alias char-major-144 pppox
# IrDA
alias char-major-161 ircomm-tty
# USB
alias char-major-166 acm
#alias char-major-180	  usbcore
alias char-major-240 usb-serial
alias binfmt-332 iBCS
alias binfmt-518 iBCS
alias binfmt-204 binfmt_aout
alias binfmt-263 binfmt_aout
alias binfmt-264 binfmt_aout
alias binfmt-267 binfmt_aout
alias binfmt-0064 binfmt_aout
alias binfmt-0008 binfmt_aout
alias iso9660 isofs
alias tty-ldisc-1 slip
alias tty-ldisc-3 ppp
alias tty-ldisc-5 mkiss
# alias tty-ldisc-7       6pack
alias tty-ldisc-7 off
# IrDA
alias tty-ldisc-11 irtty
# alias ax0               mkiss
alias ax0 off
# alias sp0               6pack
alias sp0 off
alias slip0 slip
alias sl0 slip
alias slip1 slip
alias sl1 slip
alias ppp0 ppp
alias ppp1 ppp
alias plip0 plip
alias plip1 plip
alias ppp-compress-21 bsd_comp
alias ppp-compress-26 ppp_deflate
alias net-pf-3 ax25
# alias net-pf-3            off
alias net-pf-4 ipx
# alias net-pf-4            off
alias net-pf-5 appletalk
# alias net-pf-5            off
alias net-pf-6 netrom
# alias net-pf-6            off
alias net-pf-10 ipv6
# alias net-pf-10           off
alias net-pf-11 rose
# alias net-pf-11           off
alias net-pf-17 af_packet
alias tap0 ethertap
alias tap1 ethertap
alias tap2 ethertap
alias tap3 ethertap
alias tap4 ethertap
alias tap5 ethertap
alias tap6 ethertap
alias tap7 ethertap
alias tap8 ethertap
alias tap9 ethertap
alias tap10 ethertap
alias tap11 ethertap
alias tap12 ethertap
alias tap13 ethertap
alias tap14 ethertap
alias tap15 ethertap
# Added by YaST2, do not change
alias usb-hostadapter usb-uhci
# ALSA section {$#@begin@#$} [don't remove or move this line] vvvvv
#
# ALSA native device support, generated by YaST2
#
alias char-major-116 snd
options snd snd_major=116 snd_cards_limit=1
alias snd-card-0 snd-card-es1938
options snd-card-es1938 snd_index=0 snd_id=card1
#
# OSS/Free emulation
#
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
#
# ALSA section {$#@_end_@#$} [don't remove or move this line] ^^^^^

# YaST2: Intel Corporation 82557 [Ethernet Pro 100]
alias eth0 eepro100




Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

