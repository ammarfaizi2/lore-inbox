Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311270AbSCWUsd>; Sat, 23 Mar 2002 15:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311271AbSCWUsN>; Sat, 23 Mar 2002 15:48:13 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:37114 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S311270AbSCWUsI>; Sat, 23 Mar 2002 15:48:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Martin Blais <blais@iro.umontreal.ca>
To: Pavel Machek <pavel@suse.cz>, Martin Blais <blais@discreet.com>
Subject: Re: xxdiff as a visual diff tool (shameless plug)
Date: Sat, 23 Mar 2002 15:46:46 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there> <200203221829.NAA22671161@cuba.discreet.qc.ca> <20020322214413.GG16382@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020323204804.ZOIW905.tomts8-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 22 March 2002 16:44, Pavel Machek wrote:
> Hi!
> > that seems more like a patch problem/improvement request. i wouldn't do
> > the patch myself... however, with the rejected hunks problem, i wonder if
> > it is at all possible to avoid implementing patch functionality in the
> > diffing tool itself.
>
> Question is how to do it in patch. Even one *long line* can be too
> much, and then your horizontal highlight would come very handy.

actually, thinking more about it, having to use patch is not really a problem 
for the BK use case discussed on this list, as BK most likely can provide the 
file on the main branch and the common ancestor between the developer's 
branch and the main branch. one then just needs to spawn a 3-way xxdiff on 
those three files (with automatic selection of non-conflictual hunks). 
that's what i do with Clearcase, where all the file versions are available 
directly in the filesystem. CVS however, requires that i first fetch the file 
to a temporary copy and there is no way to figure out the common ancestor 
where the last update to the main branch occured (unless you hack it into a 
tag or something).

my point is, if you're using scm, you don't need to use patches at all, so 
there is no real need for a tool to help "wiggle patches in", in that 
context.
-----BEGIN PGP SIGNATURE-----
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyc6coACgkQq2PmC9F3Xx3LMACeJbrnBgPsFxSGuXlL8PdCdlmm
z2wAn2qNiFC6sgpz4yQZKMGV1DzIeayx
=rB+O
-----END PGP SIGNATURE-----
