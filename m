Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279846AbRJ3EJv>; Mon, 29 Oct 2001 23:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279850AbRJ3EJl>; Mon, 29 Oct 2001 23:09:41 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:5052 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S279846AbRJ3EJ0>; Mon, 29 Oct 2001 23:09:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 30 Oct 2001 16:09:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15326.13845.325990.742520@notabene.cse.unsw.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        miles@megapathdsl.net, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: What is standing in the way of opening the 2.5 tree? (quotas?)
In-Reply-To: message from Andreas Dilger on Sunday October 28
In-Reply-To: <1004219488.11749.19.camel@stomata.megapathdsl.net>
	<3BDB91D7.C7975C44@mandrakesoft.com>
	<20011027.224602.74750641.davem@redhat.com>
	<20011028185844.C1311@lynx.no>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 28, adilger@turbolabs.com wrote:
> On Oct 27, 2001  22:46 -0700, David S. Miller wrote:
> > In particular, the quota stuff, which has sat in Alan's tree forever.
> > If Linus is ignoring the changes it probably is for a good reason
> > but it would be nice for him to let Alan know what that reason is :-)
> 
> AFAIK (not much, since I don't use quotas), the on-disk quota format used
> by Alan's tree was changed to support 32-bit UID/GIDs, which makes it
> incompatible with that used in the Linus tree.  However, there was also
> some quota merging done in 2.4.13 or so, which _may_ have resolved
> this.

This is one of the reasons I haven't been using the -ac kernels:  I
would have to reformat my quota files.  And then if I had to back
out, I would have to reformat them again...

I had a quick look at the code in -ac and it should be possible to
detect with a fair degree of certainty whether the file is in the old
format or the new format, and to select between approriate read/write
methods accordingly.   I suspect that would make the new quota stuff
an acceptable change for a "stable" kernel (chuckle chuckle).

NeilBrown

P.S. No, I'm not volunteering.
