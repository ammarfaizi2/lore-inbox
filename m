Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269131AbTCBALe>; Sat, 1 Mar 2003 19:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbTCBALe>; Sat, 1 Mar 2003 19:11:34 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:63407 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S269131AbTCBALa>; Sat, 1 Mar 2003 19:11:30 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, pavel@janik.cz, pavel@ucw.cz,
       hch@infradead.org
Date: Sat, 1 Mar 2003 16:20:26 -0800 (PST)
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <200303020011.QAA13450@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0303011616510.17904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam, the openbkweb project didn't reverse engineer the BK network
protocol, it used the HTTP access that is provided on bkbits.net to
download the individual items and created a repository from that.

unfortunantly the bandwidth requirements to support that are high enough
that Larry indicated that if people keep doing that he would have to
shutdown the HTTP access.

bitbucket uses rsync as that is the most efficiant way to get a copy of
the repository without trying to talk the bitkeeper protocol. it is FAR
more efficiant and accruate then the openbkkweb interface

Davdi Lang


 On Sat, 1 Mar 2003, Adam J.
Richter wrote:

> Date: Sat, 1 Mar 2003 16:11:55 -0800
> From: Adam J. Richter <adam@yggdrasil.com>
> To: andrea@suse.de, linux-kernel@vger.kernel.org, pavel@janik.cz,
>      pavel@ucw.cz
> Cc: hch@infradead.org
> Subject: Re: BitBucket: GPL-ed KitBeeper clone
>
> Pavel Machek wrote:
> > I've created little project for read-only (for now ;-) kitbeeper
> > clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
> > just get it fresh from CVS).
>
> 	Thank you for taking some initiative and improving this
> situation by constructive means.  You are an example to us all,
> as is Andrea Arcangeli with his openbkweb project, which you
> will probably want to examine and perhaps integrate
> (ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/openbkweb).
>
> 	bitbucket is about 350 lines of shell scripts, documentation
> and diffs, the most interesting file of which is FORMAT, which
> documents some reverse engineering efforts on bitkeeper internal file
> formats.  bitkbucket currently uses rsync to update data from the
> repository.  openbkweb is 500+ lines of python that implements enough
> of the bitkeeper network protocol to do downloads, although perhaps in
> inefficiently.  That sounds like some functionality that you might be
> interested in integrating.
>
> 	I think the suggestion made by Pavel Janik that it would
> be better to work on adding BitKeeper-like functionality to existing
> free software packages is a bit misdirected.  BitKeeper uses SCCS
> format, and we have a GPL'ed SCCS clone ("cssc"), so you are
> adding functionality to existing free software version control
> code anyhow.
>
> 	However, I would like to turn Pavel Janik's point in
> what I think might be a more constructive direction.
>
> 	Aegis, BitKeeper and probably other configuration management
> tools that use sccs or rcs basically share a common type of lower
> layer.  This lower layer converts a file-based revision control system
> such as sccs to an "uber-cvs", as someone called it in a slashdot
> discussion, that can:
>
> 	    1. process a transaction against a group of files atomically,
> 	    2. associate a comment with such a transaction rather than
> 	       with just one file,
> 	    3. represent symbolic links, file protections
>             4. represent file renames (and perhaps copies?)
>
> 	You might want to keep in the back of your mind the
> possibility of someday splitting off this lower level into a separate
> software package that programs like your bitkeeper clone, aegis could
> use in common.  If the interface to this lower level took cvs
> commands, then it could probably replace cvs, although the repository
> would probably be incompatible since the meaning of things like
> checking in multiple files together with a single comment would be
> different, and there would be other kinds of changes to represent
> beyond what cvs currently does.  Using a repository format that is
> compatible with another system (for example bitkeeper or aegis) would
> make such a tool more useful, and if such a tool makes it easier for
> people to migrate from a prorprietary system to a free one, that's
> even better, so your starting with bitkeeper's format seems like an
> excellent choice to me.
>
> 	Thanks again for starting this project.  I will at least
> try to be a user of it.
>
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
