Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbRAUJaj>; Sun, 21 Jan 2001 04:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRAUJaa>; Sun, 21 Jan 2001 04:30:30 -0500
Received: from mta02.mail.au.uu.net ([203.2.192.82]:21135 "EHLO
	mta02.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S130205AbRAUJaU>; Sun, 21 Jan 2001 04:30:20 -0500
Message-ID: <3A6AAC61.F8B850BC@coldfusion.4mg.com>
Date: Sun, 21 Jan 2001 20:31:13 +1100
From: STiNG of DEATH <nsmail12@coldfusion.4mg.com>
Reply-To: linux@coldfusion.4mg.com
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Problems with Askey TView CPH061 grabber board under bttv
Content-Type: multipart/mixed;
 boundary="------------3C4A413AD69ADFF2ABEE51B2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3C4A413AD69ADFF2ABEE51B2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I recently bought an Askey TView CPH061 video grabber board based on a
Bt878
chip with a Temic tuner (PAL-BG because I live in Australia.). It works
quite
well for composite inputs and UHF channels (thanks Gerd and others :-),
however 
it will not receive any VHF channels.
(Please see "http://www.vk2nnn.com/spectrum.html#Australian TV Channels"
for
a table of Australian TV frequencies.)

Even when I generate a test signal and feed it directly into the card,
when
I try and tune that frequency on the VHF band all I get is static.
I can't receive any television signals on any of the VHF channels, but I
can
receive two UHF stations (one of them quite weak.)

I have put the card into a Windows based machine and installed the
Windows
drivers and it can receive all channels on all bands, so I'm putting it
down
to an anomoly in the Linux bttv drivers.

This is very bizzare, as when I look at the debug output from the tuner
module, it appears from the kernel messages that the card is being tuned
to the correct frequency. I know there is a station on that frequency
yet I
don't get any picture or sound, so obviously the tuner driver is saying
one thing and doing another.

Also, when the bttv driver loads, it detects the board as card number 38
(Tview 99 CPH061x) when the card is really number 24 (Askey Magic TView
CPH061x.) I have specified the real card number as an insmod option,
however
neither card number seem to have any effect on the problem.

I am using the version of bttv that comes with kernel 2.4.0 (I would get
the
latest bttv from CVS, but I can't seem to get onto Gerd's site, it looks
like
it's down..) I am using XawTV 3.26 built from source to watch TV.

I have attached the kernel output from when the bttv modules are loaded
and my conf.modules file. I hope someone can help me out. I guess the
problem
could be something in tuner.c that is not tuning the VHF bands properly.
I checked all the frequencies in the debug output with the Australian
frequency table (link at the top of this post) and they all seem to
check
out. I'm a bit lost for ideas, not being an expert at bttv and the
kernel.

I have sent this message to both the kernel list and the video4linux
list.
Please CC any replies back to me as well as the list. Thankyou in
advance

-Patrick Burns
--------------3C4A413AD69ADFF2ABEE51B2
Content-Type: text/plain; charset=us-ascii;
 name="bttv4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bttv4"

Jan 21 19:51:11 stingofdeath kernel: bttv: driver version 0.7.50 loaded 
Jan 21 19:51:11 stingofdeath kernel: bttv: using 2 buffers with 2080k (4160k total) for capture 
Jan 21 19:51:11 stingofdeath kernel: bttv: Bt8xx card found (0). 
Jan 21 19:51:11 stingofdeath kernel: PCI: Found IRQ 10 for device 00:09.0 
Jan 21 19:51:11 stingofdeath kernel: PCI: The same IRQ used for device 00:09.1 
Jan 21 19:51:11 stingofdeath kernel: bttv0: Bt878 (rev 2) at 00:09.0, irq: 10, latency: 32, memory: 0xed104000 
Jan 21 19:51:11 stingofdeath kernel: bttv0: subsystem: 144f:3000  =>  TView 99 (CPH063)  =>  card=38 
Jan 21 19:51:11 stingofdeath kernel: bttv0: model: BT878(Askey/Typhoon/Anubis Ma) [insmod option] 
Jan 21 19:51:11 stingofdeath kernel: i2c-core.o: adapter bt848 #0 registered as adapter 0. 
Jan 21 19:51:11 stingofdeath kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found 
Jan 21 19:51:11 stingofdeath kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found 
Jan 21 19:51:11 stingofdeath kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found 
Jan 21 19:51:11 stingofdeath kernel: i2c-core.o: driver i2c TV tuner driver registered. 
Jan 21 19:51:11 stingofdeath kernel: tuner: chip found @ 0x60 
Jan 21 19:51:11 stingofdeath kernel: bttv0: i2c attach [Temic PAL] 
Jan 21 19:51:11 stingofdeath kernel: i2c-core.o: client [Temic PAL] registered to adapter [bt848 #0](pos. 0). 
Jan 21 19:51:11 stingofdeath kernel: bttv0: open called 
Jan 21 19:51:12 stingofdeath last message repeated 11 times
Jan 21 19:51:12 stingofdeath kernel: tuner: tv freq set to 527.25 
Jan 21 19:51:12 stingofdeath kernel: bttv0: open called 
Jan 21 19:53:10 stingofdeath kernel: bttv0: open called 
Jan 21 19:53:10 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:10 stingofdeath kernel: bttv0: PLL: 28636363 => 35468950 ... ok 
Jan 21 19:53:10 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:11 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:11 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:11 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:11 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:16 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:16 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:17 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:17 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:17 stingofdeath kernel: tuner: tv freq set to 64.25 
Jan 21 19:53:24 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:24 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:25 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:25 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:25 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:25 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:26 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:26 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:27 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:27 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:27 stingofdeath kernel: tuner: tv freq set to 182.25 
Jan 21 19:53:28 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:28 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:29 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:29 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:29 stingofdeath kernel: tuner: tv freq set to 196.25 
Jan 21 19:53:29 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:29 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:30 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:30 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:30 stingofdeath kernel: tuner: tv freq set to 209.25 
Jan 21 19:53:31 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:31 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:33 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:33 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:33 stingofdeath kernel: tuner: tv freq set to 527.25 
Jan 21 19:53:34 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:34 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:35 stingofdeath kernel: Display at e0000000 is 1024 by 768, bytedepth 2, bpl 2048 
Jan 21 19:53:35 stingofdeath kernel: bttv0: clip: ro=00228000 re=01bf8000 
Jan 21 19:53:35 stingofdeath kernel: tuner: tv freq set to 548.25 

--------------3C4A413AD69ADFF2ABEE51B2
Content-Type: text/plain; charset=us-ascii;
 name="conf.modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="conf.modules"

# PPP networking
alias ppp-compress-21 bsd_comp
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate
alias char-major-108 ppp_generic
alias tty-ldisc-3 ppp_async
alias ppp0 ppp

# SCSI scanner
# alias char-major-21 sym53c416 sg
options sym53c416 sym53c416=0x820,7

# ALSA sound modules
alias char-major-116 snd
options snd snd_major=116 snd_cards_limit=1
alias snd-card-0 snd-card-cs461x
post-install snd-mixer /usr/sbin/alsactl restore
post-install snd-card-cs461x /usr/sbin/alsactl restore

# OSS/Free setup
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias synth1 snd-seq-oss

# Encrypted filesystems
alias loop-xfer-gen-0 loop_gen
alias cipher-11 rc62

# CD burner
options ide-cd ignore=hdc #              Don't run CD as IDE
alias scd0 sr_mod #              Load sr_mod for SCSI cd0
pre-install sg 'modprobe ide-scsi' #              Load IDE burners before sg
pre-install sr_mod 'modprobe ide-scsi' #              Load IDE burners before sr_mod
pre-install ide-scsi 'modprobe ide-cd' #              Load IDE CD-ROMS _before_ burners
# Make sure that IDE CDs are claimed before they are snapped up by
# ide-scsi. Also make sure ide-scsi loaded before scsi gen operations.
probeall scsi_hostadapter sym53c416 ide-scsi

# Network Hardware
alias eth0 8139too
alias eth1 tulip

# Network channel bonding driver
# alias bond0 bonding

# Infrared Devices (for video capture card remote)
alias char-major-61 lirc_gpio
# alias char-major-61 lirc_sir

# TV Tuner and Video Capture Devices
# i2c bus
alias char-major-89 i2c-dev
options i2c-core i2c_debug=1
# options i2c-algo-bit bit_test=1
# bttv driver
alias char-major-81 bttv
alias char-major-81-0 bttv
options bttv pll=28 card=24 bttv_debug=1
options tuner type=0 debug=1

# alias ip_tables iptable_mangle
alias char-major-6 parport

--------------3C4A413AD69ADFF2ABEE51B2--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
