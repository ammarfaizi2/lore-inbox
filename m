Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUHHT71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUHHT71 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUHHT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:59:27 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:55203 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266214AbUHHT7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:59:24 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: linux-kernel@vger.kernel.org
Subject: Re: [Problem] 2.6.8-rc3: usb-storage devices are read-only (NOT related to iocharset)
Date: Sun, 8 Aug 2004 22:09:23 +0200
User-Agent: KMail/1.5
References: <200408082157.35469.rjwysocki@sisk.pl>
In-Reply-To: <200408082157.35469.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408082208.02328.rjwysocki@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 of August 2004 21:57, R. J. Wysocki wrote:
> Hi list,
>
> On 2.6.8-rc3 and 2.6.8-rc2-mm2 I get:
>
> chimera:~ # mount  -t vfat -o iocharset=iso8859-2 /dev/sdd1 /media/pendrive
> chimera:~ # mount
> [snip]
> /dev/sdd1 on /media/pendrive type vfat (rw,iocharset=iso8859-2)
> chimera:~ # mkdir /media/pendrive/test
> mkdir: cannot create directory `/media/pendrive/test': Read-only file
> system chimera:~ # umount /media/pendrive
> chimera:~ # mount  -t vfat -o codepage=437 /dev/sdd1 /media/pendrive
> chimera:~ # mount
> [snip]
> /dev/sdd1 on /media/pendrive type vfat (rw,codepage=437)
> chimera:~ # mkdir /media/pendrive/test
> mkdir: cannot create directory `/media/pendrive/test': Read-only file
> system
>
> The system is SuSE 9.1/AMD64 (with updates), the kernel config and hardware
> data are attached.

Oh, I see that floppies are affected in the same way, so possibly it is a 
problem of the vfat module vs mount.  If I am right, can you please tell me 
what to do to mount these things rw anyway?

Yours,
rjw

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
