Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbRLLCQr>; Tue, 11 Dec 2001 21:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLLCQj>; Tue, 11 Dec 2001 21:16:39 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:15060 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S285050AbRLLCQV>; Tue, 11 Dec 2001 21:16:21 -0500
Date: Wed, 12 Dec 2001 02:16:18 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Reply-To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Hans Reiser <reiser@namesys.com>
cc: Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
In-Reply-To: <3C169DCD.8060806@namesys.com>
Message-ID: <Pine.SOL.3.96.1011212015827.2712B-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Hans Reiser wrote:
> Anton Altaparmakov wrote:
> >I was just stating a fact of how they are stored on NTFS, again something
> >I have no power to change.
> >
> But does NTFS specificism/cripplism belong in VFS?

No, of course not. But the vfs needs to be able to cope with limitations
of specific file systems (even if it is only by passing -Exyz into
userspace).

> >>Well, gosh, okay, maybe you want to prepend ',,' to streams and '..' to 
> >>extended attributes.  I personally think Linux would only want to do so 
> >>when used as a fileserver emulating NTFS/SAMBA.  There is no enhancement 
> >>of user functionality from doing it for general purpose filesystems. 
> >
> >Just wait until this functionality is available and watch all GUI things
> >start to use it en masse! I don't doubt that GNOME/KDE/replace with your
> >favourite window manager are going to hesitate to start putting in the
> >icon, the name, and whatnot inside EAs or inside named streams the instant
> >they are ubiquitously available and I think that makes a lot of sense too.
> >No doubt I will get flamed for saying this but all flames go to
> >/dev/null...
> >
> >Both MacOS and as of recently Windows do this kind of stuff, too, and it
> >can't be long before Linux goes the same way, provided file systems
> >support the required features (i.e. EAs and/or named streams) so I
> >disagree with you this is only a compatibility thing. It might start out
> >as one but it will find real world applications very quickly...
> >
> I am not saying that the features of EAs are not useful, I am saying 
> that I want to choose them individually for particular files.
> 
> It could be so much better to have EDIBLE_PIZZA (example from previous 
> email) instead of just PIZZA, sigh.

I am not quite sure what you mean. Surely you can just have all features
available at all times/to all files and then you just use the ones you
want, just ignoring/not using the rest. Why do you see the need for
"selecting features of EAs individually for particular files"? It makes
sense when buying EDIBLE_PIZZA but I don't see how that can be transferred
onto files. After all I can just have all pizza ingredients and only put
the ones I want on the pizza just ignoring the others.

Um, I think we might be saying the same thing in different words...

> >>Programs will get written to use your API, and not work with reiserfs, 
> >>and will get written to use our API and not work with NTFS, and this is 
> >>bad....
> >
> >Now that is true. And yes, it is bad. However it will be up to the
> >community to decide which API to use and at the moment there are several
> >fs using the "bestbits" API and only reiserfs (?) the "reiserfs" one...
> >And we all know from our very own $Deity that we don't design software, we
> >just write things and let evolution decide which is better. (((-;
> >
> Fortunately he isn't entirely consistent on this point.:-)
> 
> I predict you guys will ship first and get a lot of usage, and then we 
> will ship later with more features,
> and the result will be a mess for users.  This is the usual evolutionary 
> design standards mess.  

Yes, your prediction will likely hold true IMO.

> Objectively, I understand it is highly reasonable for the Linux 
> community to assume that what we
> implement will be horrible until we finish it.  I would encourage it to 
> assume that someone else
> will eventually get orthogonalism right though, and I think it would be 
> worth waiting for it, because
> these are the sorts of design features that stick around for 30 years. 
>  I don't really expect that most folks will choose to wait though.

Me neither. People want it now, which pretty much limits the choice to
one of the things available and working now, plus some required cleanups
to satisfy all $Deities so the solution can be accepted in the kernel...

The one who comes first gets to populate the vacuum. Evolution at its
best. (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


