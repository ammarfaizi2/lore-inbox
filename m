Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280323AbRJaRpW>; Wed, 31 Oct 2001 12:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280355AbRJaRpM>; Wed, 31 Oct 2001 12:45:12 -0500
Received: from [63.231.122.81] ([63.231.122.81]:57953 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280358AbRJaRoz>;
	Wed, 31 Oct 2001 12:44:55 -0500
Date: Wed, 31 Oct 2001 10:44:31 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e2fsck bogus message
Message-ID: <20011031104431.B16554@lynx.no>
Mail-Followup-To: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01103112432903.00794@nemo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <01103112432903.00794@nemo>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Oct 31, 2001 at 12:43:29PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  12:43 +0000, vda wrote:
> e2fsck complains "Your /etc/fstab does not contain the fsck
> passno field..." when there are no entries in /etc/fstab.
> This message is bogus in this case.
> 
> Why I don't have any entries?
> I refer to my root fs as /dev/root (thanks to devfs)
> and I have nothing else to mount yet.

Actually it is NOT a bogus complaint.  If you don't have root in /etc/fstab,
then it will never be checked by fsck.  You still need something like:

/dev/root	/	ext2	defaults	1	1

Also, this is NOT a kernel problem, so it shouldn't be reported to
this list.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

