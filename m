Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbTAQHHq>; Fri, 17 Jan 2003 02:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTAQHHq>; Fri, 17 Jan 2003 02:07:46 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:17086 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S267414AbTAQHHp>; Fri, 17 Jan 2003 02:07:45 -0500
Content-Type: text/plain;
  charset="iso-2022-jp"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Mamoru Yamanishi <yama@o2.biotech.okayama-u.ac.jp>
Subject: Re: PROBLEM: bad device file for cdrom while using devfs and ide-scsi
Date: Fri, 17 Jan 2003 08:16:51 +0100
User-Agent: KMail/1.4.3
References: <200301171304.55582.yama@o2.biotech.okayama-u.ac.jp>
In-Reply-To: <200301171304.55582.yama@o2.biotech.okayama-u.ac.jp>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301170816.51641@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [2.] Full description of the problem/report:
>
> 	I use Kernle-2.4.20 with devfs and ide-scsi.
> 	"devfs" is mounted at boot.
>
> 	I wonder that the symbolic-link to actual device file of cdrom is not
> 	correct, which is placed in /dev as
>
> 		"cdrom0 -> ../scsi/host0/bus0/target0/lun0/cd"
>
> 	It should be placed in subdirectory /dev/cdroms, or it should be
> 	linked to "scsi/host0/bus0/target0/lun0/cd", I think.
>
> 	Without ide-scsi, there is /dev/cdroms/cdrom0 which is correctry
> 	linked to actual device file.
>
> 	I was looking around the kernel source codes, but I cannot find
> 	where it was.

Are you sure that sr_mod is loaded? After installing ide-scsi the cdrom drive 
is a scsi cdrom so you must load the scsi cdrom driver (module sr_mod). If it 
is not in the `lsmod` output you should try "modprobe sr_mod".

Eike
