Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292406AbSBYXct>; Mon, 25 Feb 2002 18:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292402AbSBYXck>; Mon, 25 Feb 2002 18:32:40 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:34828 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S292398AbSBYXce>; Mon, 25 Feb 2002 18:32:34 -0500
Date: Tue, 26 Feb 2002 00:32:30 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
Message-ID: <20020225233230.GB11786@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020225.140851.31656207.davem@redhat.com> <3C7AB893.4090800@ellinger.de> <20020225230156.GA11786@merlin.emma.line.org> <20020225.150813.66161624.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225.150813.66161624.davem@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, David S. Miller wrote:

>    From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
>    Date: Tue, 26 Feb 2002 00:01:56 +0100
> 
>    > And how should EXTRAVERSION be accommodated?
>    
>    sed/perl/awk -- a short five-liner "bless-rc-to-final" script should do.
> 
> Ummm... no.
> 
> This whole conversation exists because "Deleting the EXTRAVERSION
> setting from linux/Makefile" then making new diffs/tars was screwed
> up.  Doing it with a script isn't going to help this kind of problem.
> 
> I repeat: it isn't a "release candidate" if it will not match preciely
> what the final tarball/patches contains.  Anything else opens up the
> possibility for errors to be made.

I'd think that running a script to "upgrade" 2.4.N-rcM to 2.4.N by just
unpacking that latest rc tarball, editing the Makefile and tarring
things up again, should be safe enough, and if it doesn't allow for
operator interference, especially so. 

I'd rather violate the "it's not a release candidate if it changes to
the final release" than have differing versions with the same tag
around, which would be a support nightmare. "Does the person who
reported this bug run the release candidate or the final version?" That
question is hard to answer if you cannot ask for uname -r, but end up
asking for the MD5sum of that tarball, and that still does not account
for patches, patches missed and patches applied -- Would you want that?
I would not.

I think that the coupling between tag and corresponding code should be
tighter than that of the release candidate to the release, but I don't
decide on this issue, Marcelo does.

-- 
Matthias Andree

GPG encrypted mail welcome, unless it's unsolicited commercial email.
