Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSK1Itt>; Thu, 28 Nov 2002 03:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSK1Itt>; Thu, 28 Nov 2002 03:49:49 -0500
Received: from angband.namesys.com ([212.16.7.85]:47746 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265275AbSK1Its>; Thu, 28 Nov 2002 03:49:48 -0500
Date: Thu, 28 Nov 2002 11:57:08 +0300
From: Oleg Drokin <green@namesys.com>
To: Sonke Ruempler <ruempler@topconcepts.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiserfs bug
Message-ID: <20021128115708.A2792@namesys.com>
References: <072801c296b8$2cb01000$6600a8c0@topconcepts.net> <20021128114755.A2724@namesys.com> <077201c296bb$43b4ac40$6600a8c0@topconcepts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <077201c296bb$43b4ac40$6600a8c0@topconcepts.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Nov 28, 2002 at 09:50:55AM +0100, Sonke Ruempler wrote:
> > There should be another message in your logs prior to above,
> > can you please tell us what was that message?
> Nov 28 09:05:15 blah kernel:  I/O error: dev 08:11, sector 283064
> Nov 28 09:05:15 blah kernel: zam-7001: io error in reiserfs_find_entry
> Nov 28 09:05:15 blah kernel:  I/O error: dev 08:11, sector 283064
> Nov 28 09:05:15 blah kernel: vs-13050: reiserfs_update_sd: i/o failure
> occurred trying to update [2 58464 0x0 SD] stat dataSCSI disk error : host 2
> channel 0 id 1 lun 0 return code = 10000
> Nov 28 09:05:15 blah kernel:  I/O error: dev 08:11, sector 283064
> Nov 28 09:05:20 blah kernel: vs-13050: reiserfs_update_sd: i/o failure
> occurred trying to update [2 58464 0x0 SD] stat dataSCSI disk error : host 2
> channel 0 id 1 lun 0 return code = 10000
> Nov 28 09:05:20 blah kernel:  I/O error: dev 08:11, sector 11496
> Nov 28 09:05:20 blah kernel: SCSI disk error : host 2 channel 0 id 1 lun 0
> return code = 10000
> Nov 28 09:05:20 blah kernel:  I/O error: dev 08:11, sector 11504
> Nov 28 09:05:20 blah kernel: journal-601, buffer write failed

Sorry, but you seems to have faulty hardware (bad harddrive or something).
Reiserfs cannot tolerate bad blocks in journal area right now.
I'd suggest you to make a backup of your device and then to replace bad
harddrive.

Bye,
    Oleg
