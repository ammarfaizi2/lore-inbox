Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283267AbRL1AMe>; Thu, 27 Dec 2001 19:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283310AbRL1AMX>; Thu, 27 Dec 2001 19:12:23 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:40953 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283267AbRL1AMJ>;
	Thu, 27 Dec 2001 19:12:09 -0500
Date: Thu, 27 Dec 2001 17:11:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Dave Jones <davej@suse.de>, Steven Walter <srwalter@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <20011227171130.O12868@lynx.no>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Dave Jones <davej@suse.de>, Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011227202345.B30930@conectiva.com.br> <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de> <20011227163130.N12868@lynx.no> <20011227214047.D30930@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011227214047.D30930@conectiva.com.br>; from acme@conectiva.com.br on Thu, Dec 27, 2001 at 09:40:47PM -0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2001  21:40 -0200, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 27, 2001 at 04:31:30PM -0700, Andreas Dilger escreveu:
> > Well, in the past I had suggested to ESR (and he agreed) that it would
> > be nice to split up the MAINTAINERS file (and maybe even Configure.help)
> 
> this already happens for the net/ directory to some degree, look at
> net/README, the problem, as with MAINTAINERS, is that is way outdated,
> listing Alan, for example, as the maintainer for net/core...

Well, if the MAINTAINERS file isn't up-to-date (which I know it isn't,
see "Remy Card" as ext2 maintainer) then there isn't much that can be
done by users/developers to submit patches to the right people at all.
I think part of the problem is Linus' hesitance to be authoritarian and
add/remove people from the MAINTAINERS list if they don't specifically
ask for the change (and submit a patch to that effect).

Yes, long time readers of l-k know that Dave (and Alexy) is the contact
for net stuff, and Al is the contact for VFS stuff, but nobody else does.
Also, how many emails (in addition to my own) were sent to Remy Card for
ext2 fixes (who is even listed with "Maintained" after his name), yet in
the entire time I've been working on Linux I have never seen a single
email from him (in private or public).  Urgh, Remy is also listed in the
under the ext3 entry, how did _that_ happen Andrew?  MAINTAINERS != CREDITS

Someone (sadly not me) needs to take over MAINTAINERS like ESR took over
Configure.help and "ping" all of the maintainers that haven't been heard
from and either do some searching for new email addresses, or delete them
entirely from the file.  This may ruffle a few feathers, but in the end it
will just be documenting what "the old boys' network of l-k" already knows
and does for patch submission today.

Having a heirarchical MAINTAINER file as I proposed also means:
a) It is closer to the code in question, and _someone_ will be on the hook
   for the code in that tree, at least until they delegate it elsewhere.
   The descriptions in the current MAINTAINERS file are sometimes hard to
   link to specific files if you don't really understand what is going on.
b) It is easier to update more frequently because there are less chances
   of patch conflicts (minor issue I know).
c) It is easier to keep external patchsets, as they can have their own
   MAINTAINER (and Configure.help) within the tree.

As for "interested parties", this could rather easily be handled by adding
an entry to the MAINTAINER for various parts of the heirarchy which is a
mailing list (e.g. linux-mm@nl.linux.org in mm/MAINTAINER, linux-scsi@...
in drivers/scsi/MAINTAINER, etc).  These would also be listed by the
hypothetical "cclist" tool included with the kernel.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

