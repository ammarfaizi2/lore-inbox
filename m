Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280782AbRKKEkm>; Sat, 10 Nov 2001 23:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280925AbRKKEkc>; Sat, 10 Nov 2001 23:40:32 -0500
Received: from nitro.med.uc.edu ([129.137.3.151]:5458 "HELO nitro.msbb.uc.edu")
	by vger.kernel.org with SMTP id <S280782AbRKKEkQ>;
	Sat, 10 Nov 2001 23:40:16 -0500
Date: Sat, 10 Nov 2001 23:39:48 -0500 (EST)
From: Jack Howarth <howarth@nitro.med.uc.edu>
Message-Id: <200111110439.XAA53352@nitro.msbb.uc.edu>
To: linux-kernel@vger.kernel.org
Subject: ide-floppy.c vs devfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,
   Is ide-floppy supposed to be devfs friendly? I ask
because on Linux 2.4.15-pre2 (and previous kernels)
on the Powermac (Debian ppc sid) I find that the
ide-floppy driver only creates device for my ide 
zip if a zip disk is inserted at boot time. Otherwise
the /dev/ide/host1/bus0/target1/lun0 directory doesn't
contain a device node for the zip whereas the ide-cdrom
driver creates a /dev/ide/host1/bus0/target0/lun0/cd
fine without a cdrom disk inserted at boot time. I find
that the only way I can get the zip device created at
boot time without media inserted is to use ide-scsi 
emulation and turn off ide-floppy when I configure the
kernel. Is this issue a known problem and does it
exist for other arches than powerpc (Powermac)? Thanks
in advance for any advice.
                      Jack
------------------------------------------------------------------------------
Jack W. Howarth, Ph.D.                                    231 Albert Sabin Way
NMR Facility Director                              Cincinnati, Ohio 45267-0524
Dept. of Molecular Genetics                              phone: (513) 558-4420
Univ. of Cincinnati College of Medicine                    fax: (513) 558-8474
