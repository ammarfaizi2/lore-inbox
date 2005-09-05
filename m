Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVIEU5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVIEU5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVIEU5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:57:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932530AbVIEU53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:57:29 -0400
Date: Mon, 5 Sep 2005 13:55:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: kernel status, 5 Sep 2005
Message-Id: <20050905135546.7732ec27.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(If replying to this email, please rewrite the Subject: to something
appropriate)


Current kernel version
----------------------

  2.6.13-git5

ETA for 2.6.14
--------------

  October 7 (wild guess, probably optimistic)

Status of subsystem trees
-------------------------

    (size in bytes)
    3312230                git-acpi.patch
    117                    git-alsa.patch
    96                     git-arm.patch
    100                    git-arm-smp.patch
    36867                  git-audit.patch
    4124                   git-cpufreq.patch
    19679                  git-cryptodev.patch
    121                    git-drm.patch
    122                    git-drm-via.patch
    121011                 git-ia64.patch
    68419                  git-input.patch
    32153                  git-ipsec.patch
    13536                  git-jfs.patch
    53950                  git-kbuild.patch
    91786                  git-libata-all.patch
    96                     git-mmc.patch
    7729                   git-mtd.patch
    151552                 git-netdev-all.patch
    1455038                git-net.patch
    143861                 git-nfs.patch
    119                    git-ntfs.patch
    1347960                git-ocfs2.patch
    88697                  git-scsi-block.patch
    188137                 git-scsi-iscsi.patch
    658496                 git-scsi-misc.patch
    121                    git-scsi-rc-fixes.patch
    99                     git-serial.patch
    114                    git-sparc64.patch
    96                     git-ucb.patch
    57177                  git-watchdog.patch

  That's a lot of unmerged stuff.  If these things aren't merged this
  week, they're likely to be deferred into 2.6.15.

  There are also 170 patches pending in Greg's trees.

-mm merge plans
---------------

  SELinux atomic-inode-security-labeling patches:

    Waiting to hear back from Stephen Smalley.  Will merge if they're
    considered good to go.

  ocfs2

    As far as I know the remaining sticking point here is the private
    vma walking code.  That'll take another week or two to sort out. 
    Probable merge.

  ^i386-*

    These are the virtualisation preparation patches.  I'll probably
    dump all these and pick them up from Chris Wright's new virtualisation
    git tree.

  relayfs

    Will merge

  pselect/ppoll system calls

    Will merge

  Secure Digital drivers

    Will merge

  Corgi/w100fb drivers

    Will merge

  smcs-ircc updates

    Will merge

  kprobes updates

    Will merge

  rapidio drivers

    These appear to be stalled.

  Big DVB update

    Will merge

  PCMCIA updates

    Will merge

  CPU scheduler updates

    Will merge some

  Switch task_struct.thread_info to task_struct.state

    Will merge

  files_lock RCUification

    Will merge

  reiser4

    Stuck.  Last time we discussed this I asked the reiser4 team to
    develop and negotiate a bullet-point list of things to be addressed. 
    Once that's agreed to, implement it and then we can merge it.  None of
    that has happened and as far as I know, all the review feedback which
    was provided was lost.

  v9fs

    Will merge

  fbdev patches

    Will merge

  md patches

    Will merge

  FUSE

    Will merge.  Am fed up with arguing - any remaining problems can be
    fixed up in-tree if anyone can think of how to fix them.

  Everything else

    There's lots of this.  Most of it will be merged.

Open bugs
---------

  Tracking 144 bugs.  I haven't culled these yet - some may be fixed.

[Bugme-new] [Bug 4771] New: Linux 2.6.11.10 + reiserfs + usrquota,
	http://bugzilla.kernel.org/show_bug.cgi?id=4771

[Bugme-new] [Bug 4776] New: uhci_hcd: host controller halted,
	http://bugzilla.kernel.org/show_bug.cgi?id=4776

[Bugme-new] [Bug 4777] New: Cyrix 6x86MX PR200+ incorrectly
	http://bugzilla.kernel.org/show_bug.cgi?id=4777

[Bugme-new] [Bug 4779] New: amd64: raw1394 returns EINVAL
	http://bugzilla.kernel.org/show_bug.cgi?id=4779

[Bugme-new] [Bug 4781] New: Conservative governor makes me lose my
	http://bugzilla.kernel.org/show_bug.cgi?id=4781

[Bugme-new] [Bug 4823] New: alsa modules snd_virmidi & snd_mpu401
	http://bugzilla.kernel.org/show_bug.cgi?id=4823

variable used before set

	(scsi bug which nobody will fix)

[Bugme-new] [Bug 4829] New: Problem with sym53c8xx_2 and target
	http://bugzilla.kernel.org/show_bug.cgi?id=4829

[Bugme-new] [Bug 4831] New: Bad soundcard patches for Intel ICH4
	http://bugzilla.kernel.org/show_bug.cgi?id=4831

[Bugme-new] [Bug 4851] New: x86-64 userspace random segfaults and
	http://bugzilla.kernel.org/show_bug.cgi?id=4851

AACRAID failure with 2.6.13-rc1

[Bugme-new] [Bug 4853] New: pf: Oops with Imation SuperDisk
	http://bugzilla.kernel.org/show_bug.cgi?id=4853

[Bugme-new] [Bug 4860] New: sata_sx4 doesn't recognize Promise
	http://bugzilla.kernel.org/show_bug.cgi?id=4860

[Bugme-new] [Bug 4869] New: Screen stays blank upon resume
	http://bugzilla.kernel.org/show_bug.cgi?id=4869

[Bugme-new] [Bug 4880] New: dpt_i2o.c does not register itself with
	http://bugzilla.kernel.org/show_bug.cgi?id=4880

[Bugme-new] [Bug 4888] New: kernel 2.6.12.2 will only do audio when
	http://bugzilla.kernel.org/show_bug.cgi?id=4888

[Bugme-new] [Bug 4916] New: USB mouse stops working after inserting
	http://bugzilla.kernel.org/show_bug.cgi?id=4916

[Bugme-new] [Bug 4917] New: Lacie 250Go USB
	http://bugzilla.kernel.org/show_bug.cgi?id=4917

[Bugme-new] [Bug 4919] New: APM resume: freeze at disk access
	http://bugzilla.kernel.org/show_bug.cgi?id=4919

[Bugme-new] [Bug 4920] New: IDE CD Driver not able to read audio
	http://bugzilla.kernel.org/show_bug.cgi?id=4920

[Bugme-new] [Bug 4929] New: problem with aic7xxx driver on 2.6.x
	http://bugzilla.kernel.org/show_bug.cgi?id=4929

[Bugme-new] [Bug 4944] New: uhci_hcd hangs on intel 810 when
	http://bugzilla.kernel.org/show_bug.cgi?id=4944

[Bugme-new] [Bug 4963] New: Encounter this Kernel oops while
	http://bugzilla.kernel.org/show_bug.cgi?id=4963

[Bugme-new] [Bug 4966] New: ehci_hcd on x86_64 causes more than
	http://bugzilla.kernel.org/show_bug.cgi?id=4966

.13 mptfusion changes.

sysfs double entry.

[Bugme-new] [Bug 4968] New: sata_nv buffer I/O errors
	http://bugzilla.kernel.org/show_bug.cgi?id=4968

[Bugme-new] [Bug 4971] New: dual head and 2.6.13rc4
	http://bugzilla.kernel.org/show_bug.cgi?id=4971

BUG: Kernel panic when disconnecting Edirol USB2 audio interface

[Bugme-new] [Bug 4974] New: ide2usb adapter do not working with usb
	http://bugzilla.kernel.org/show_bug.cgi?id=4974

2.6.13-rc4 use after free in class_device_attr_show

[Bugme-new] [Bug 4978] New: Failed to allocate mem resource for AGP
	http://bugzilla.kernel.org/show_bug.cgi?id=4978

[Bugme-new] [Bug 4981] New: changes in 2.6.12-rc1 causes ati-remote
	http://bugzilla.kernel.org/show_bug.cgi?id=4981

[Bugme-new] [Bug 4982] New: Usenet gateway crashes under heavy
	http://bugzilla.kernel.org/show_bug.cgi?id=4982

[Bugme-new] [Bug 4983] New: Paralell ZIP disappearing
	http://bugzilla.kernel.org/show_bug.cgi?id=4983

lpfc: system freezing if FC connection is broken under load

b44 transmit timeout with kernel 2.6

[Bugme-new] [Bug 4998] New: "init 0" broken between 2.6.12 and
	http://bugzilla.kernel.org/show_bug.cgi?id=4998

Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5

[Bugme-new] [Bug 5000] New: fan always on after waking from swsusp 
	http://bugzilla.kernel.org/show_bug.cgi?id=5000

Re: tungsten t5 doesn't sync anymore with kernel 2.6.12

[Bugme-new] [Bug 5001] New: USB: usblp must be unloaded before
	http://bugzilla.kernel.org/show_bug.cgi?id=5001

Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:

oops with 2.6.13-rc5 on webserver with raid

[Bug 4995] Kernel came out with OOPs when tried to kill vmmstress [mmap] programs
	http://bugzilla.kernel.org/show_bug.cgi?id=4995

[Bugme-new] [Bug 5003] New: Problem with symbios driver on recent
	http://bugzilla.kernel.org/show_bug.cgi?id=5003

[Bug 4962] b2c2-flexcop module freezes
	http://bugzilla.kernel.org/show_bug.cgi?id=4962

Re: ns558 mis-detects gameport

[Bugme-new] [Bug 5004] New: NFS slowdown problem
	http://bugzilla.kernel.org/show_bug.cgi?id=5004

[Bugme-new] [Bug 5005] New: nForce 2 doesn't power-off
	http://bugzilla.kernel.org/show_bug.cgi?id=5005

Re: Elitegroup K7S5A + usb_storage problem

[Bugme-new] [Bug 5006] New: nForce 2 doesn't power-off
	http://bugzilla.kernel.org/show_bug.cgi?id=5006

[Bugme-new] [Bug 5007] New: ALSA sounds eventually goes crazy and
	http://bugzilla.kernel.org/show_bug.cgi?id=5007

ICMP broken in 2.6.13-rc5

[Bugme-new] [Bug 5008] New: os_wait_semaphore errors from setting
	http://bugzilla.kernel.org/show_bug.cgi?id=5008

[Bugme-new] [Bug 5010] New: ehci-hcd does not work for external
	http://bugzilla.kernel.org/show_bug.cgi?id=5010

[linux-usb-devel] Fw: Re: Elitegroup K7S5A + usb_storage problem

[Bugme-new] [Bug 5012] New: moxa tty driver name is wrong and
	http://bugzilla.kernel.org/show_bug.cgi?id=5012

RE: As of 2.6.13-rc1 Fusion-MPT very slow

[Bugme-new] [Bug 5014] New: rp_filter proc interface generate oops
	http://bugzilla.kernel.org/show_bug.cgi?id=5014

[Bugme-new] [Bug 5017] New: pcmcia: trouble inserting network card
	http://bugzilla.kernel.org/show_bug.cgi?id=5017

[Bugme-new] [Bug 5018] New: can't resume from swsusp with amd64-agp
	http://bugzilla.kernel.org/show_bug.cgi?id=5018

[Bugme-new] [Bug 5019] New: pcmcia causes swsusp suspend hang
	http://bugzilla.kernel.org/show_bug.cgi?id=5019

[Bugme-new] [Bug 5025] New: Excessive time to connect to cable
	http://bugzilla.kernel.org/show_bug.cgi?id=5025

[Bugme-new] [Bug 5027] New: Usermode speed governor is dangerous on
	http://bugzilla.kernel.org/show_bug.cgi?id=5027

[Bugme-new] [Bug 5029] New: 2.6.12 kernel memory leak
	http://bugzilla.kernel.org/show_bug.cgi?id=5029

2.6 select doesn't notify readablity of /proc/loadavg.

irqpoll causing some breakage?

[Bugme-new] [Bug 5030] New: kernel: eth1: Oversized Ethernet frame
	http://bugzilla.kernel.org/show_bug.cgi?id=5030

[Bugme-new] [Bug 5031] New: Sempron 2800+ (1.6GHz) sleeps half as
	http://bugzilla.kernel.org/show_bug.cgi?id=5031

[Bugme-new] [Bug 5035] New: ibm_acpi hotkeys don't work anymore
	http://bugzilla.kernel.org/show_bug.cgi?id=5035

[Bugme-new] [Bug 5036] New: snd_generic_pm misses release() causes
	http://bugzilla.kernel.org/show_bug.cgi?id=5036

[Bugme-new] [Bug 5037] New: S3 sleep hangs often [TP 600X]
	http://bugzilla.kernel.org/show_bug.cgi?id=5037

[Bugme-new] [Bug 5039] New: high cpu usage (softirq takes 50% all
	http://bugzilla.kernel.org/show_bug.cgi?id=5039

[Bugme-new] [Bug 5042] New: setrlimit/getrlimit broken on 32-bit
	http://bugzilla.kernel.org/show_bug.cgi?id=5042

[Bugme-new] [Bug 5044] New: PCI automatic routing on Dell Optiplex
	http://bugzilla.kernel.org/show_bug.cgi?id=5044

[Bugme-new] [Bug 5046] New: Switching elevator on-the-fly causes
	http://bugzilla.kernel.org/show_bug.cgi?id=5046

[Bugme-new] [Bug 5047] New: sata hangs (Silicon Image and seagate
	http://bugzilla.kernel.org/show_bug.cgi?id=5047

[Bugme-new] [Bug 5048] New: Batery state is completely messed up
	http://bugzilla.kernel.org/show_bug.cgi?id=5048

[Bugme-new] [Bug 5049] New: doubled keystrokes especially with
	http://bugzilla.kernel.org/show_bug.cgi?id=5049

rc6 keeps hanging and blanking displays where rc4-mm1 works fine.

Simple DoS with ioprio

[Bugme-new] [Bug 5052] New: USB Palm Error Causing Keyboard Removal
	http://bugzilla.kernel.org/show_bug.cgi?id=5052

[Bugme-new] [Bug 5053] New: after wake, serial port not working
	http://bugzilla.kernel.org/show_bug.cgi?id=5053

[Bugme-new] [Bug 5054] New: cannot change debug_level or debug_layer
	http://bugzilla.kernel.org/show_bug.cgi?id=5054

[Bugme-new] [Bug 5055] New: HFS+-fs: walked past end of dir
	http://bugzilla.kernel.org/show_bug.cgi?id=5055

[Bugme-new] [Bug 5059] New: intelfb - do not keep console resolution
	http://bugzilla.kernel.org/show_bug.cgi?id=5059

[Bugme-new] [Bug 5062] New: kernel preemption breaks in several ways
	http://bugzilla.kernel.org/show_bug.cgi?id=5062

[Bugme-new] [Bug 5063] New: usb camera failing in 2.6.13-rc6
	http://bugzilla.kernel.org/show_bug.cgi?id=5063

[Bugme-new] [Bug 5064] New: Oops Unable to handle NULL pointer
	http://bugzilla.kernel.org/show_bug.cgi?id=5064

[Bugme-new] [Bug 5065] New: Network Card SIS900 does not work when
	http://bugzilla.kernel.org/show_bug.cgi?id=5065

[Bugme-new] [Bug 5067] New: [Patch] Hotkeys do not work on Samsung
	http://bugzilla.kernel.org/show_bug.cgi?id=5067

[Bugme-new] [Bug 5069] New: vga consoles are illegible after S3 wake
	http://bugzilla.kernel.org/show_bug.cgi?id=5069

[Bugme-new] [Bug 5071] New: Cardbus: PCMCIA or PCI bug ioport bug.
	http://bugzilla.kernel.org/show_bug.cgi?id=5071

http://bugzilla.kernel.org/show_bug.cgi?id=5057

[Bugme-new] [Bug 5074] New: /sys/module/*/parameters/* not working
	http://bugzilla.kernel.org/show_bug.cgi?id=5074

[Bugme-new] [Bug 5077] New: unexpected "DT_GETPAGE: dtree page
	http://bugzilla.kernel.org/show_bug.cgi?id=5077

[Bugme-new] [Bug 5078] New: r8169: eth0: PHY reset until link up
	http://bugzilla.kernel.org/show_bug.cgi?id=5078

[Bugme-new] [Bug 5080] New: bonding related oops on boot
	http://bugzilla.kernel.org/show_bug.cgi?id=5080

[Bugme-new] [Bug 5082] New: speedstep_smi produces FATAL error on
	http://bugzilla.kernel.org/show_bug.cgi?id=5082

[Bugme-new] [Bug 5084] New: IRQ routing problems causes many errors
	http://bugzilla.kernel.org/show_bug.cgi?id=5084

[Bugme-new] [Bug 5085] New: NFS file corruption after
	http://bugzilla.kernel.org/show_bug.cgi?id=5085

[Bugme-new] [Bug 5086] New: unplugging webcam when stv680 is in use
	http://bugzilla.kernel.org/show_bug.cgi?id=5086

[Bugme-new] [Bug 5093] New: atmel_cs hangs during swsusp
	http://bugzilla.kernel.org/show_bug.cgi?id=5093

[Bugme-new] [Bug 5094] New: Get an ops message from the kernel with
	http://bugzilla.kernel.org/show_bug.cgi?id=5094

[Bugme-new] [Bug 5098] New: Oops when disconnecting Iriver
	http://bugzilla.kernel.org/show_bug.cgi?id=5098

Re: Slow sync in Interbench: anticipatory starves writes?

[Bugme-new] [Bug 5099] New: Power down when rebooting 2.6.13-rc6
	http://bugzilla.kernel.org/show_bug.cgi?id=5099

[Bugme-new] [Bug 5100] New: No batt. after resume
	http://bugzilla.kernel.org/show_bug.cgi?id=5100

2.6.13-rc6-commit-2ba8... crash on firmware load

[Bugme-new] [Bug 5105] New: lost ticks - hang check - after loading
	http://bugzilla.kernel.org/show_bug.cgi?id=5105

[Bugme-new] [Bug 5107] New: S3 Suspend: wakeup but no video,
	http://bugzilla.kernel.org/show_bug.cgi?id=5107

[Bugme-new] [Bug 5109] New: kernel BUG in hfsplus
	http://bugzilla.kernel.org/show_bug.cgi?id=5109

Re: Process in D state with st driver

[Bugme-new] [Bug 5122] New: cpufreq/powernowd is still not working
	http://bugzilla.kernel.org/show_bug.cgi?id=5122

[Bugme-new] [Bug 5126] New: No sound on Thinkpad X31 (Intel
	http://bugzilla.kernel.org/show_bug.cgi?id=5126

[Bugme-new] [Bug 5127] New: Lost ticks compensation fires when it
	http://bugzilla.kernel.org/show_bug.cgi?id=5127

[Bugme-new] [Bug 5130] New: atyfb driver kernel panic on boot on
	http://bugzilla.kernel.org/show_bug.cgi?id=5130

[Bugme-new] [Bug 5137] New: r8169 - network dies.
	http://bugzilla.kernel.org/show_bug.cgi?id=5137

[Bugme-new] [Bug 5138] New: 64bit put_unaligned/get_unaligned does
	http://bugzilla.kernel.org/show_bug.cgi?id=5138

[Bug 5137] r8169 - network dies.
	http://bugzilla.kernel.org/show_bug.cgi?id=5137

[Bugme-new] [Bug 5143] New: USB HID,
	http://bugzilla.kernel.org/show_bug.cgi?id=5143

[Bugme-new] [Bug 5144] New: ext3 memory leaks (size-64 objects)
	http://bugzilla.kernel.org/show_bug.cgi?id=5144

[Bugme-new] [Bug 5150] New: Aironet 352 PCMCIA can't be activated
	http://bugzilla.kernel.org/show_bug.cgi?id=5150

[Bugme-new] [Bug 5151] New: Driver Mouse - Toshiba touchpad after
	http://bugzilla.kernel.org/show_bug.cgi?id=5151

[Bugme-new] [Bug 5152] New: 2.6.13 hangs during boot
	http://bugzilla.kernel.org/show_bug.cgi?id=5152

[Bugme-new] [Bug 5154] New: 2.6.13 crashes on heavy used server
	http://bugzilla.kernel.org/show_bug.cgi?id=5154

[Bugme-new] [Bug 5156] New: llc2: llc_ui_bind() leaves llc->dev NULL
	http://bugzilla.kernel.org/show_bug.cgi?id=5156

[Bugme-new] [Bug 5158] New: ps/2 keyboard on x86_64 does not work
	http://bugzilla.kernel.org/show_bug.cgi?id=5158

[Bugme-new] [Bug 5159] New: BUG: soft lockup detected on CPU#0!
	http://bugzilla.kernel.org/show_bug.cgi?id=5159

[Bugme-new] [Bug 5160] New: Sound not working with bttv driver
	http://bugzilla.kernel.org/show_bug.cgi?id=5160

[Bugme-new] [Bug 5163] New: x crashes at startup
	http://bugzilla.kernel.org/show_bug.cgi?id=5163

[Bugme-new] [Bug 5164] New: pl2303 when unplugged while device is
	http://bugzilla.kernel.org/show_bug.cgi?id=5164

kernel BUG at kernel/workqueue.c:104!

2.6.13-rc7: crash on removing CF card

2.6.13 and the IRQs

2.6.13 - strange usb keyboard behaviour

[Bugme-new] [Bug 5170] New: Kernel BUG at "fs/exec.c":788
	http://bugzilla.kernel.org/show_bug.cgi?id=5170

[Bugme-new] [Bug 5173] New: USB subsystems hangs when stressing the
	http://bugzilla.kernel.org/show_bug.cgi?id=5173

[x86_64] Exception when using powernowd.

[Bugme-new] [Bug 5171] New: Linux-2.6.13 crash on boot
	http://bugzilla.kernel.org/show_bug.cgi?id=5171

[2.6.13 bug] i386: Wall clock running at double speed

[Bugme-new] [Bug 5181] New: kernel BUG at drivers/md/raid10.c:1448!
	http://bugzilla.kernel.org/show_bug.cgi?id=5181

[Bug 4377] Severe memory leak issue
	http://bugzilla.kernel.org/show_bug.cgi?id=4377

[Bugme-new] [Bug 5186] New: performance drop down 300% and more

	http://bugzilla.kernel.org/show_bug.cgi?id=5186

