Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSDCC3n>; Tue, 2 Apr 2002 21:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313018AbSDCC33>; Tue, 2 Apr 2002 21:29:29 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:43780 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S313016AbSDCC2L>; Tue, 2 Apr 2002 21:28:11 -0500
Date: Tue, 2 Apr 2002 18:28:03 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Question about 'Hidden' Directories in ext2
Message-ID: <20020402182803.G19384@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0204021704360.6590-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 05:16:42PM -0500, Calin A. Culianu wrote:
> 
> Ok, so some hackers broke into one of our boxes and set up an ftp site.
> They monopolized over 70gb of hard drive space with warez and porn.  We
> aren't really that upset about it, since we thought it was kind of funny.
> (Of course we don't like the idea that they are using out bandwidth and
> disk space, but we can easily remedy that).
> 
> Anyway, the weird thing is they created 2 directories, both of which were
> strangely hidden.  You can cd into them but you can't ls them.  I
> 
> /usr/lib/ypx and /usr/man/ypx were the two directories that contained both
> the ftp software and the ftp root.  When you are in /usr/man and you do an
> ls, you don't see the ypx directory (same when you are in /usr/lib).  The
> ls binary we got is right off the redhat cd so it shouldn't still be
> compromised by whatever rootkit was installed.
> 
> My question is this: can the data structures in ext2fs be somehow hacked
> so a directory can't appear in a listing but can be otherwise located for
> a stat or a chdir?  I should think no.. maybe we still haven't gotten rid
> of the rootkit...
> 
> -Calin

It might be much simpler.  They may be playing with /etc/profile.
Check your shell aliases and the environment variable LS_OPTIONS.
A simple LS_OPTIONS="$LS_OPTIONS -I ypx" or
alias ls='ls --ignore=ypx' would have the effect you are
talking about.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
