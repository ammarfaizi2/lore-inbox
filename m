Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSENKgw>; Tue, 14 May 2002 06:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315600AbSENKgv>; Tue, 14 May 2002 06:36:51 -0400
Received: from dsl-213-023-062-041.arcor-ip.net ([213.23.62.41]:51218 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S315599AbSENKgu>;
	Tue, 14 May 2002 06:36:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Ext3 errors with 2.4.18
Date: Tue, 14 May 2002 12:38:09 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <3CD6AE7A.FBEB5726@delusion.de>
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205141238.11104.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2002 18:25, Udo A. Steinberg wrote:
> Hi,
>
> With Linux 2.4.18, I'm getting multiple of the following error:
>
> EXT3-fs error (device ide0(3,2)): ext3_readdir: bad entry in directory
> #1966094: rec_len % 4 != 0 - offset=0, inode=3180611420, rec_len=53134,
> name_len=138

Hi,

I experienced the same problem with ext3 + 2.4.18 on a RAID-1. Out of nowhere 
the following error popped up in the syslog, no other surrounding error 
messages. The fs was mounted read-only automatically. After reboot and fsck 
there were /a lot/ of errors on the disk. Virtually all errors fsck knows I 
think. :)  After fsck ran multiple times on the disk, lost+found was filled 
with stuff from all accross the disk, but other than that the fs seems to 
have survived it.

May 14 01:24:41 kianga kernel: EXT3-fs error (device md(9,0)): ext3_readdir: 
bad entry in directory
#2142115: rec_len %% 4 != 0 - offset=0, inode=4186379891, rec_len=16755, 
name_len=219
May 14 01:24:51 kianga last message repeated 2 times

Regards,
Oliver

-- 
Oliver Feiler  <kiza@(gmx.net|lionking.org|claws-and-paws.com|spot.dtip.de)> /
http://www.lionking.org/~kiza/      (http://spot.dtip.de/)                  /
___________________________________________________________________________/
