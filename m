Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVIGIwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVIGIwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 04:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVIGIwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 04:52:36 -0400
Received: from odin2.bull.net ([192.90.70.84]:63724 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932076AbVIGIwf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 04:52:35 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: george@mvista.com
Subject: Re: [patch] KGDB for Real-Time Preemption systems
Date: Wed, 7 Sep 2005 10:55:53 +0200
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
References: <20050811110051.GA20872@elte.hu> <43028A94.1050603@mvista.com>
In-Reply-To: <43028A94.1050603@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509071055.54016.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mercredi 17 Août 2005 02:53, George Anzinger wrote/a écrit :
> I have put a version of KGDB for x86 RT kernels here:
> http://source.mvista.com/~ganzinger/
>
> The common_kgdb_cfi_.... stuff creates debug records for entry.S and
> friends so that you can "bt" through them.  Apply in this order:
> Ingo's patch
> kgdb-ga-rt.patch
> common_kgdb_cfi_annotations.patch
>
> This is, more or less, the same kgdb that is in Andrew's mm tree changed
> to fix the RT issues.

I'm trying this kgdb patch with 2.6.13 and I get the following errors.
Is there something I forgot ?

...
  INSTALL sound/usb/snd-usb-audio.ko
  INSTALL sound/usb/snd-usb-lib.ko
  INSTALL sound/usb/usx2y/snd-usb-usx2y.ko
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map 
-b /var/tmp/kernel-2.6.13-rt4-root -r 2.6.13-rt4; fi
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/net/sunrpc/sunrpc.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/net/appletalk/appletalk.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/fs/reiserfs/reiserfs.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/fs/ntfs/ntfs.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/fs/nfs/nfs.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/fs/minix/minix.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/fs/jbd/jbd.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/fs/ext3/ext3.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/fs/cifs/cifs.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/fs/affs/affs.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/drivers/scsi/libata.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/drivers/scsi/ide-scsi.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/drivers/scsi/gdth.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/drivers/md/raid6.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/drivers/md/raid5.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/drivers/ide/ide-floppy.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/drivers/block/pktcdvd.ko 
needs unknown symbol preempt_locks
WARNING: /var/tmp/kernel-2.6.13-rt4-root/lib/modules/2.6.13-rt4/kernel/drivers/block/loop.ko 
needs unknown symbol preempt_locks
make[3]: *** [_modinst_post] Erreur 1
erreur: Mauvais status de sortie pour /var/tmp/rpm-tmp.51405 (%install)


Erreur de construction de RPM:
    Mauvais status de sortie pour /var/tmp/rpm-tmp.51405 (%install)
make[2]: *** [rpm] Erreur 1
make[1]: *** [rpm] Erreur 2
make: *** [rpm] Erreur 2
