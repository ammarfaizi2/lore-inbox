Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVHEJJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVHEJJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVHEJJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:09:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262926AbVHEJIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:08:38 -0400
Date: Fri, 5 Aug 2005 02:07:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: kernel status, 4 Aug 2005
Message-Id: <20050805020729.50146221.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At kernel summit I pledged to put out weekly where-we're-at summaries,
mainly so that subsystem maintainers could get an estimate of when the next
major kernel release will be, so they can plan their merge windows.

Of course, I don't have a clue when the next release will be because the
timing is driven by perception-of-stability.  But I can guess.

Current kernel version:

  2.6.13-rc5-git3

ETA for 2.6.13:

  August 12-19

Status of subsystem trees:

  3190002    git-acpi.patch
  68299      git-alsa.patch
  96         git-arm.patch
  100        git-arm-smp.patch
  31799      git-audit.patch
  113        git-cpufreq.patch
  14257      git-cryptodev.patch
  107590     git-drm.patch
  122        git-drm-via.patch
  112        git-ia64.patch
  109        git-input.patch
  32153      git-ipsec.patch
  4781       git-jfs.patch
  41254      git-kbuild.patch
  21659      git-libata-adma-mwi.patch
  17964      git-libata-chs-support.patch
  36338      git-libata-ncq.patch
  21535      git-libata-passthru.patch
  3944       git-libata-promise-sata-pata.patch
  91         git-libata-upstream-fixes.patch
  85         git-libata-upstream.patch
  96         git-mmc.patch
  7729       git-mtd.patch
  255866     git-netdev-chelsio.patch
  10606      git-netdev-e100.patch
  1290162    git-netdev-ieee80211-wifi.patch
  48220      git-netdev-sis190.patch
  4899       git-netdev-smc91x-eeprom.patch
  132        git-netdev-upstream-fixes.patch
  178991     git-netdev-upstream.patch
  955        git-net-gregkh-i2c-w1-netlink-callbacks-fix.patch
  443989     git-net.patch
  101        git-nfs.patch
  119        git-ntfs.patch
  1321859    git-ocfs2.patch
  88683      git-scsi-block.patch
  331078     git-scsi-misc.patch
  121        git-scsi-rc-fixes.patch
  34584      git-serial.patch
  1890       git-sparc64.patch

	That's all 2.6.14 material - no subsystem merges pending.

Open bugs:

  This is based on my reading of what's real and of what's worth
  attending to.  Quite a few things get culled up-front.

  There are several emailed bug reports which are probably live bugs but
  they have gone stale hence I have asked the reporters to raise bugzilla
  reports, so more post-2.6.12 bugs will appear as the reporters retest
  2.6.13-rc6.

  I really don't want to have to track bugs which aren't in bugzilla.  If
  an emailed bug report comes in and we can address it within a few days
  and a few emails then fine.  If that doesn't happen I'll be asking
  reporters to open bugzilla reports.

  All bugs reported prior to the 2.6.12 release have been discarded. 
  I'll henceforth track bugs across succeeding major release, so this list
  will just grow.

  There are 60 bugs here.  They're almost all post-2.6.12 regressions. 
  Longer-term we simply have to do better than this, else we'll stabilise
  at a pretty buggy level.  No matter what process changes we make, the
  bottom line is that developers/maintainers will need to spend more of
  their time working with reporters on fixing bugs.

  If you wish to provide an update on one of the below bugs, please do it
  in bugzilla if it's bugzilla-based.  Or in reply to the original email
  thread if it's email-based.  Failing all that, please at least rewrite
  the Subject: when replying so I don't lose my mind, thanks.


  Lots of USB stuff, some ACPI and we seem to have broken parallel-IDE.


idr_remove

	Looks like SELinux is removing IDR entries which don't exist.

[Bugme-new] [Bug 4768] New: Screen appears at mid-right section
  http://bugzilla.kernel.org/show_bug.cgi?id=4768

[Bugme-new] [Bug 4769] New: PC104plus BT848 card stop working in
  http://bugzilla.kernel.org/show_bug.cgi?id=4769

[Bugme-new] [Bug 4771] New: Linux 2.6.11.10 + reiserfs + usrquota,
  http://bugzilla.kernel.org/show_bug.cgi?id=4771

Re: 2.6.12-rc6-mm1

  This is the

	note: mono[26736] exited with preempt_count 1
	scheduling while atomic: mono/0x10000001/26736

  x86_64 bug.

[Bugme-new] [Bug 4773] New: 8139too module got "eth0: transmit
  http://bugzilla.kernel.org/show_bug.cgi?id=4773

[Bugme-new] [Bug 4776] New: uhci_hcd: host controller halted,
  http://bugzilla.kernel.org/show_bug.cgi?id=4776

[Bugme-new] [Bug 4777] New: Cyrix 6x86MX PR200+ incorrectly
  http://bugzilla.kernel.org/show_bug.cgi?id=4777

[Bugme-new] [Bug 4779] New: amd64: raw1394 returns EINVAL
  http://bugzilla.kernel.org/show_bug.cgi?id=4779

[Bugme-new] [Bug 4781] New: Conservative governor makes me lose my
  http://bugzilla.kernel.org/show_bug.cgi?id=4781

[Bugme-new] [Bug 4791] New: ACPI + SERIO_I8042 bug/conflict
  http://bugzilla.kernel.org/show_bug.cgi?id=4791

[Bugme-new] [Bug 4793] New: Battery reads result in high cpu usage
  http://bugzilla.kernel.org/show_bug.cgi?id=4793

[Bugme-new] [Bug 4823] New: alsa modules snd_virmidi & snd_mpu401
  http://bugzilla.kernel.org/show_bug.cgi?id=4823

variable used before set

  Silly scsi bug.

2.6.12-rc6 mm->total_vm accounting imbalance?

  Might be fixed

[Bugme-new] [Bug 4829] New: Problem with sym53c8xx_2 and target
  http://bugzilla.kernel.org/show_bug.cgi?id=4829

[Bugme-new] [Bug 4831] New: Bad soundcard patches for Intel ICH4
  http://bugzilla.kernel.org/show_bug.cgi?id=4831

[Bugme-new] [Bug 4851] New: x86-64 userspace random segfaults and
  http://bugzilla.kernel.org/show_bug.cgi?id=4851

AACRAID failure with 2.6.13-rc1

  Might be fixed

[Bugme-new] [Bug 4853] New: pf: Oops with Imation SuperDisk
  http://bugzilla.kernel.org/show_bug.cgi?id=4853

[Bugme-new] [Bug 4860] New: sata_sx4 doesn't recognize Promise
  http://bugzilla.kernel.org/show_bug.cgi?id=4860

[Bugme-new] [Bug 4866] New: motherboard ga-k8nf-9: ehci_hcd doesn't
  http://bugzilla.kernel.org/show_bug.cgi?id=4866

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

[Bugme-new] [Bug 4940] New: Repeatable Kernel Panic on Adaptec
  http://bugzilla.kernel.org/show_bug.cgi?id=4940

[Bugme-new] [Bug 4944] New: uhci_hcd hangs on intel 810 when
  http://bugzilla.kernel.org/show_bug.cgi?id=4944

[Bugme-new] [Bug 4950] New: battery state don't change
  http://bugzilla.kernel.org/show_bug.cgi?id=4950

[Bug 4951] System freezes with SMP kernel on AMD X2 4600
  http://bugzilla.kernel.org/show_bug.cgi?id=4951

[Bugme-new] [Bug 4962] New: ?
  http://bugzilla.kernel.org/show_bug.cgi?id=4962

[Bugme-new] [Bug 4963] New: Encounter this Kernel oops while
  http://bugzilla.kernel.org/show_bug.cgi?id=4963

[Bugme-new] [Bug 4965] New: Dual-head not working correctly with
  http://bugzilla.kernel.org/show_bug.cgi?id=4965

[Bugme-new] [Bug 4966] New: ehci_hcd on x86_64 causes more than
  http://bugzilla.kernel.org/show_bug.cgi?id=4966

.13 mptfusion changes.

  mpt-fusion needs initrd rework and will break existing userspace.

sysfs double entry.

  duplicate entries in /sys/devices/system/

[Bugme-new] [Bug 4968] New: sata_nv buffer I/O errors
  http://bugzilla.kernel.org/show_bug.cgi?id=4968

[Bugme-new] [Bug 4971] New: dual head and 2.6.13rc4
  http://bugzilla.kernel.org/show_bug.cgi?id=4971

Re: [linux-usb-devel] Fw: BUG: Kernel panic when disconnecting Edirol USB2 audio interface

2.6.13-rc4 - kernel panic - BUG at net/ipv4/tcp_output.c:918

[Bugme-new] [Bug 4974] New: ide2usb adapter do not working with usb
  http://bugzilla.kernel.org/show_bug.cgi?id=4974

Re: 2.6.13-rc4 use after free in class_device_attr_show

[Bugme-new] [Bug 4978] New: Failed to allocate mem resource for AGP
  http://bugzilla.kernel.org/show_bug.cgi?id=4978

[Bugme-new] [Bug 4981] New: changes in 2.6.12-rc1 causes ati-remote
  http://bugzilla.kernel.org/show_bug.cgi?id=4981

[Bugme-new] [Bug 4982] New: Usenet gateway crashes under heavy
  http://bugzilla.kernel.org/show_bug.cgi?id=4982

[Bugme-new] [Bug 4983] New: Paralell ZIP disappearing
  http://bugzilla.kernel.org/show_bug.cgi?id=4983

Re: aio-fix-races-in-callback-path.patch added to -mm tree

[Bugme-new] [Bug 4992] New: Power off stops
  http://bugzilla.kernel.org/show_bug.cgi?id=4992

lpfc: system freezing if FC connection is broken under load

MCE problem on dual Opteron

PROBLEM: reproductible oops, NFS, gigabit network, x86_64

b44 transmit timeout with kernel 2.6

[Bugme-new] [Bug 4998] New: "init 0" broken between 2.6.12 and
  http://bugzilla.kernel.org/show_bug.cgi?id=4998

Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5

[Bugme-new] [Bug 5000] New: fan always on after waking from swsusp 
  http://bugzilla.kernel.org/show_bug.cgi?id=5000

Re: tungsten t5 doesn't sync anymore with kernel 2.6.12

[Bugme-new] [Bug 5001] New: USB: usblp must be unloaded before Scanner is available, MFP Epson CX3650 (& Epson CX6600)
  http://bugzilla.kernel.org/show_bug.cgi?id=5001
