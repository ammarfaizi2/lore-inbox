Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWAWWAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWAWWAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWAWWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:00:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31152 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932383AbWAWWAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:00:19 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:
	Rationale for RLIMIT_MEMLOCK?)
From: Lee Revell <rlrevell@joe-job.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <43D54E81.nailC6M5ZIPCH@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
	 <1138014312.2977.37.camel@laptopd505.fenrus.org>
	 <20060123165415.GA32178@merlin.emma.line.org>
	 <1138035602.2977.54.camel@laptopd505.fenrus.org>
	 <20060123180106.GA4879@merlin.emma.line.org>
	 <1138039993.2977.62.camel@laptopd505.fenrus.org>
	 <20060123185549.GA15985@merlin.emma.line.org>
	 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
	 <20060123212119.GI1820@merlin.emma.line.org>
	 <1138051613.21481.37.camel@mindpipe>  <43D54E81.nailC6M5ZIPCH@burner>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 17:00:16 -0500
Message-Id: <1138053617.21481.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 22:45 +0100, Joerg Schilling wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Mon, 2006-01-23 at 22:21 +0100, Matthias Andree wrote:
> > > Sounds really good. Can you give a pointer as to the detailed rlimit
> > > requirements? 
> >
> > I don't want to touch the rest of the thread, but the best info on the
> > above can be found in the linux-audio-user list archives.  It's still a
> > little unclear exactly which packages are required, but IIRC PAM 0.80
> > supports it already.  I believe this requires glibc changes eventually,
> > but programs like PAM and bash that deal with rlimits can work around it
> > if glibc is not aware of the new rlimit.
> 
> Could you explain this more in depth?
> 
> What you describe looks like you propose to add a line:
> 
> joerg::::defaultpriv=file_dac_read,sys_devices,proc_lock_memory,proc_priocntl,net_privaddr
> 
> to /etc/user_attr which would be honored by PAM during login.
> 
> This is not what I like to see.
> 
> What I like to see is that only specific programs like cdrecord
> would get the permissions to do more than joe user.

It's not that fine grained, it works at a user/group level.

You would add a line like:

@cdrecord        hard    rtprio           80

to /etc/security/limits.conf and add users to the cdrecord group.

Lee

