Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312190AbSCRDsP>; Sun, 17 Mar 2002 22:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312192AbSCRDsG>; Sun, 17 Mar 2002 22:48:06 -0500
Received: from zok.SGI.COM ([204.94.215.101]:64975 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S312190AbSCRDrt>;
	Sun, 17 Mar 2002 22:47:49 -0500
Date: Mon, 18 Mar 2002 14:47:21 +1100
From: Nathan Scott <nathans@sgi.com>
To: Shawn Starr <spstarr@sh0n.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre3-ac1 - Quotactl patch
Message-ID: <20020318144721.G1601@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Alan Cox wrote:
> > 
> > You might want to upgrade to the newer one, the patch has undergone a lot
> > of changes and -ac against the XFS merge of the quotactl patch seriously
> > breaks ;-(
>
> The -ac patch is the current stable 2.4 one for 32bit uid quota. [...]
>

Shawn,

We are using Jan's latest "alpha" patches in XFS CVS (not the latest
"stable" patches), so you will need to follow the recipe I sent out
earlier (see below) for getting these patches to work together with
the quota patch in Alan's patches.  Following this recipe, nothing
should "seriously break" -- please let me know if it does -- and no
additional quota patches are necessary for XFS.

cheers.

-- 
Nathan


On Tue, Mar 05, 2002 at 12:59:04AM -0500, Shawn Starr wrote:
>
> I will be doing this today for -shawn10. Thank you.
>
> Shawn.
>
> On Tue, 5 Mar 2002, Nathan Scott wrote:
> > Subject: TAKE - Even newer VFS quota
> > 
> > This is Jan's latest set of VFS quota patches.  These patches (which
> > were posted to LKML on the weekend) allow the two VFS quota formats
> > and quotactl interfaces to coexist.  All seems stable on my machine.
> >
> > If you're one of the people merging XFS with Alan Cox's patches, you
> > should first reverse-apply Jan's old patches (which removes the old
> > 32 bit UID/GID quota from Alan's patches, and then apply the new code
> > from the XFS CVS tree (which "re-applies" the 32 bit UID/GID quota
> > patches, but now using Jan's new mechanisms).
> >
> > Please let us know of any quota oddities you see in the CVS tree.
> >
> > cheers.
> >
