Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUIQCEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUIQCEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 22:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUIQCEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 22:04:15 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:32480 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268490AbUIQCEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 22:04:07 -0400
Date: Fri, 17 Sep 2004 04:04:06 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Michael Scondo <michael.scondo@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat bug
Message-ID: <20040917020405.GB2573@MAIL.13thfloor.at>
Mail-Followup-To: Michael Scondo <michael.scondo@arcor.de>,
	linux-kernel@vger.kernel.org
References: <200409170013.20712.michael.scondo@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409170013.20712.michael.scondo@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 12:13:20AM +0200, Michael Scondo wrote:
> Hello..
> I've just compiled a new kernel ( 2.6.8.1 ), and now I'm not able to mount my 
> fat32 partitions anymore.
> 
> mount /dev/hda7 /mnt
> mount: wrong fs type, bad option, bad superblock on /dev/hda7,
>        or too many mounted file systems
> :-(
> 
> Every works still fine with 2.6.4, but I'm not sure, whether this occurs due 
> to a bug in the kernel or because a wrong build process.
> Therefore I'm posting this to the list.

check the kernel ring buffer (dmesg) for codepages which
are requested but not found (or other strange messages)
which appear when you 'try' to mount the filesystem

HTH,
Herbert

> I've just googled about this problem and a few other people seem to have 
> problems with fat32, too, but I'm not sure what this means to me.
> So could someone tell me please, whether this problem is reproducable or 
> already known or if it occurs only at my system ?
> 
> Thanks, Micha
> ( Please CC me, I'm not on the list )
> 
> 
> 
> ------------------------------------------------
> The system on which the kernel runs is Debian Sid:
> 
> Linux betageuze.stars 2.6.8.1 #2 Thu Sep 16 16:24:09 CEST 2004 i686 GNU/Linux
> 
> Gnu C                  3.3.3
> Gnu make               3.79.1
> binutils               2.14.90.0.7
> util-linux             2.12
> mount                  2.12
> module-init-tools      3.0-pre10
> e2fsprogs              1.35
> PPP                    2.4.2
> isdn4k-utils           3.3
> nfs-utils              1.0.6
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Procps                 3.2.1
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               5.0.91
> Modules Loaded         floppy snd_pcm_oss snd_mixer_oss sr_mod scsi_mod lp 
> parport binfmt_misc nls_cp850 smbfs dummy ext2 vfat fat psmouse snd_sb_common 
> snd_es1688 snd_opl3_lib snd_hwdep snd_es1688_lib snd_pcm snd_page_alloc 
> snd_timer snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore tulip 
> 8139too mii crc32 nfs nfsd exportfs lockd sunrpc usblp ide_cd cdrom slhc 
> uhci_hcd usbcore
> 
> CPU: Pentium 2, 400 Mhz
> 
> However, I've build the kernel at another system ( Debian Woody ):
> 
> Gnu C                  2.95.4
> Gnu make               3.79.1
> binutils               2.11.92.0.12.3
> util-linux             2.11n
> mount                  2.11n
> module-init-tools      implemented
> e2fsprogs              1.25
> nfs-utils              1.0
> Linux C Library        2.2.4
> Dynamic linker (ldd)   2.2.4
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               2.0.11
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
