Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287007AbRL1UUA>; Fri, 28 Dec 2001 15:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287000AbRL1UTq>; Fri, 28 Dec 2001 15:19:46 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:7164 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S287001AbRL1UTW>;
	Fri, 28 Dec 2001 15:19:22 -0500
Date: Fri, 28 Dec 2001 13:17:57 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jan Niehusmann <list064@gondor.com>, andersg@0x63.nu,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com
Subject: Re: [lvm-devel] Re: lvm in 2.5.1
Message-ID: <20011228131757.W12868@lynx.no>
Mail-Followup-To: Jan Niehusmann <list064@gondor.com>, andersg@0x63.nu,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	lvm-devel@sistina.com
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <3C2B75B3.4DEF90D3@zip.com.au> <20011227193711.GB20501@h55p111.delphi.afb.lu.se> <3C2B7A3E.E5C05404@zip.com.au> <20011227202451.GC20501@h55p111.delphi.afb.lu.se> <20011228164510.GA9129@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011228164510.GA9129@gondor.com>; from list064@gondor.com on Fri, Dec 28, 2001 at 05:45:10PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 28, 2001  17:45 +0100, Jan Niehusmann wrote:
> On Thu, Dec 27, 2001 at 09:24:51PM +0100, andersg@0x63.nu wrote:
> > hmm, enlarging the dummy[200] in the userspace version of lv_t seems to be a
> > nice quickndirty solution.
> 
> Please do not change the kernel / userspace interface easily. Past
> experience has shown that this leads to significant update problems,
> because kernel and userspace tools need to be updated at the same time.

But since this is a 2.5 kernel, now is the time to change it, but you must
_also_ change the IOP version in lvm.h to 12 (not 11!) if you change the
struct sizes.

Sadly, I think the work that was done in the past to support user tools
for multiple IOP versions was dropped from (or never added to) the LVM
build process, so it will not just be a matter of "install the latest
user tools and all will be well", sigh.  We had this problem with the
change from IOP6 to IOP10, and had fixed it all up, but we are doomed
to repeat the same problem over again.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

