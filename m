Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266608AbSKGWJm>; Thu, 7 Nov 2002 17:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbSKGWJm>; Thu, 7 Nov 2002 17:09:42 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:55305 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S266608AbSKGWJk>; Thu, 7 Nov 2002 17:09:40 -0500
Date: Thu, 7 Nov 2002 14:16:15 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Why are exe, cwd, and root priviledged bits of information?
Message-ID: <20021107221615.GA2249@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0211071052540.8252-100000@rtlab.med.cornell.edu> <20021107160521.GA18270@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107160521.GA18270@nevyn.them.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 11:05:21AM -0500, Daniel Jacobowitz wrote:
> On Thu, Nov 07, 2002 at 10:57:06AM -0500, Calin A. Culianu wrote:
> > 
> > In the /prod/PID subset of procfs, why are the exe, cwd, and root symlinks
> > considered priviledged information?
> > 
> > Exe is the big one for me, as this one can be usually infered from reading
> > /prod/PID/maps.  Root I guess can't be inferred in any unpriviledged way,
> > and neither can cwd.  At any rate.. I am not sure behind the philosophy to
> > make these symlinks' destinations priviledged...  can someone clarify
> > this?
> 
> This came up a little while ago.  The answer is that maps should be
> priviledged also.
> 
> For instance:
>   You can protect a directory by giving its parent directory no read
> permissions.  The name of the directory is now secret.  You don't want
> to reveal it in cwd.
> 

Daniel is correct in that the issue came up recently.  He
gives _his_ answer above.  If you believe in security
through obscurity you will agree with him.  I don't.
I will agree that there should be no real reason to need
access to this information.

With ACLs you will be able to explicitly grant access and
you won't have to depend on keeping shared info secret.
Then this will be less of an issue.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
