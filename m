Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282363AbRKXE0k>; Fri, 23 Nov 2001 23:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282362AbRKXE0a>; Fri, 23 Nov 2001 23:26:30 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:41463 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282364AbRKXE0N>;
	Fri, 23 Nov 2001 23:26:13 -0500
Date: Fri, 23 Nov 2001 21:25:57 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011123212557.U1308@lynx.no>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E167Fuw-00001K-00@DervishD> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011123174120.Q1308@lynx.no> <9tmr83$jo2$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <9tmr83$jo2$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Nov 23, 2001 at 04:56:35PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, 2001  16:56 -0800, H. Peter Anvin wrote:
> By author:    Andreas Dilger <adilger@turbolabs.com>
> > I really don't see it as being a problem (other than a purely cosmetic
> > one) to have a .journal file in your root fs.  I lived with these for a
> > couple of years OK...
> 
> It's either a cosmetic problem or a really problematic one, depending
> on how closely controlled that particular part of the namespace is.
> The .journal file could potentially try to be copied, backed up, you
> name it.

Actually, unless users are actively trying to shoot themselves in the
foot, none of this really matters.  However, now that ext3 is in the
mainline, the number of users playing with guns has increased a large
amount, it seems, by the number of such reports on ext3-users.

Because .journal is created as immutable, even if it was backed up and
tried to be restored, it would be impossible to write to.  For the
"accursed" ext2 dump, it recognizes the "nodump" flag, but also knows
enough not to back up the journal file.  Sadly, neither cpio or tar
know about ext2 attributes.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

