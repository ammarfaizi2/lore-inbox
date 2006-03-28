Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWC1RaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWC1RaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWC1RaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:30:09 -0500
Received: from nevyn.them.org ([66.93.172.17]:58831 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751185AbWC1RaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:30:07 -0500
Date: Tue, 28 Mar 2006 12:28:47 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jason L Tibbitts III <tibbs@math.uh.edu>,
       Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Message-ID: <20060328172847.GA2826@nevyn.them.org>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	Jason L Tibbitts III <tibbs@math.uh.edu>,
	Eric Piel <Eric.Piel@tremplin-utc.net>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Rob Landley <rob@landley.net>, nix@esperi.org.uk, mmazur@kernel.pl,
	linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
References: <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net> <44271E88.6040101@tremplin-utc.net> <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com> <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr> <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com> <442960B6.2040502@tremplin-utc.net> <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com> <ufazmjaec9q.fsf@epithumia.math.uh.edu> <54199D84-7DB7-434E-BA83-9B2658182124@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54199D84-7DB7-434E-BA83-9B2658182124@mac.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 12:13:15PM -0500, Kyle Moffett wrote:
> On Mar 28, 2006, at 11:59:13, Jason L Tibbitts III wrote:
> >>>>>>"KM" == Kyle Moffett <mrmacman_g4@mac.com> writes:
> >>So does anybody compile userspace under anything other than GCC or  
> >>Intel compilers?  Do any such compilers even exist?
> >
> >PGI and PathScale are around.  Lahey, too, although they seem to  
> >just do Fortran now.
> >
> >I doubt you'd want to worry about compiling the entire userland  
> >with these compilers, however.
> 
> Mainly I want to know if I should even bother making the kabi headers  
> compile with anything other than GCC.  Judging from the apparently  
> negligible number of users, it doesn't sound like something I should  
> spend much or any time on, at least for now.

I'm not sure how you got to that conclusion.  People have already named
several non-GCC compilers that are used; and most of the users of
commercial compilers won't be reading this list.

If you want glibc to ever include these things, they had better be
portable C and work without GCC.  Otherwise it's a non-starter.
Only GCC may be used to build glibc, but it deliberately supports any
conforming C compiler to build userspace code.

-- 
Daniel Jacobowitz
CodeSourcery
