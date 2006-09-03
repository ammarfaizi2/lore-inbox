Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWICVMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWICVMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 17:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWICVMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 17:12:18 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:28818 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932163AbWICVMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 17:12:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cMOxY5db7sIZwFPJZlWaEYhapxpKeC/sGH6kE85xXEuupyGxhiq/AStq5RQWNZ36quZMZlKyUDwmdzcROOg0wAtPYAs8O0Yvp5hkEOdF/Klqqy/X7j3eX67OYG6Wy6oAINbLwO2V3Uic3fw2wtTHgHVMXAHnGjOAYQpWKe0wL/M=
Message-ID: <a44ae5cd0609031412r4346b8deq2996e17f73d91f16@mail.gmail.com>
Date: Sun, 3 Sep 2006 14:12:16 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Jens Axboe" <axboe@suse.de>,
       "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.18-rc5-mm1 -- Fwd: readcd fails to read info from a WinXP created CDR
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Date: Sep 3, 2006 1:53 PM
Subject: Re: readcd fails to read info from a WinXP created CDR
To: schilling@fokus.fraunhofer.de, miles.lane@gmail.com


"Miles Lane" <miles.lane@gmail.com> wrote:

> Hello Jorg,
>
> I created a large zip file in Windows XP, then formatted a CDR and
> dragged the zipfile over to the disk in the file manager.  It got
> writting fine.  I have verified that I can read the CDR in WIndows XP
> (it shows up as a UDF disc).  But, none of the Linux apps in Ubuntu
> 6.06.1 can read this CDR, including readcd.  This would seem to be a
> fault in Linux apps.  I got all the debugging info I could using
> readcd.  Can you take a look and see whether there is anything to be
> done to get this working in Linux?

> Executing 'read toc' command on Bus 1 Target 1, Lun 0 timeout 40s
> CDB:  43 00 02 00 00 00 00 00 04 00
> readcd: Success. read toc: scsi sendcmd: no error
> CDB:  43 00 02 00 00 00 00 00 04 00
> status: 0x2 (CHECK CONDITION)
> Sense Bytes: 70 00 05 00 00 00 00 12 00 00 00 00 24 00 00 00
> Sense Key: 0x5 Illegal Request, Segment 0
> Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
> Sense flags: Blk 0 (not valid)
> resid: 4
> cmd finished after 0.005s timeout 40s
> readcd: Cannot read TOC header

This is a well known linux kernel bug.

You should start using Solaris.....


The Linux kernel bastardizes ATAPI transported SCSI commands under some
circumstances.


READ TOC & BLANK are the commands that are usually affected.

Using Solaris with exactly the same hardware verifies that it is a Linux
kernel bug.

----------------------------------------

Can we please get this fixed?

Thanks,
        Miles

-- 
VGER BF report: U 0.500002
