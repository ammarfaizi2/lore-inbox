Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUHZEwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUHZEwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267583AbUHZEwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:52:53 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:25041 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S267542AbUHZEwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:52:39 -0400
In-Reply-To: <20040826042936.GR21964@parcelfarce.linux.theplanet.co.uk>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com> <412D2BD2.2090408@sun.com> <EAB989A6-F6F9-11D8-A7C9-000393ACC76E@mac.com> <20040825180615.Z1973@build.pdx.osdl.net> <BCE1F8F8-F716-11D8-A7C9-000393ACC76E@mac.com> <20040826042936.GR21964@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C08CA144-F71B-11D8-A7C9-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Chris Wright <chrisw@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>, Tim Hockin <thockin@hockin.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Date: Thu, 26 Aug 2004 00:52:37 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 26, 2004, at 00:29, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Files and directories are not different in that respect - the only 
> overhead
> is price of hash lookup when crossing the binding in either case.  1000
> bindings shouldn't be a problem - it's 3--5 per hash chain.  Wrt 
> memory,
> it's one struct vfsmount allocated per binding - IOW, about 80Kb total
> for 1000 of those.

Where would I increase the hash size if I wanted to increase the number
of bindings by an order of magnitude or so?  I'm very interested in
pursuing this possibility, because when combined with the procedure I
described earlier, plus a little bit of extra work with capabilities 
and such
it's very easy to build incredibly flexible and basically indestructible
chroot environments with not much code.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


