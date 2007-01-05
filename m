Return-Path: <linux-kernel-owner+w=401wt.eu-S1750787AbXAEVoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbXAEVoJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXAEVoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:44:09 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:37816 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbXAEVoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:44:08 -0500
X-Greylist: delayed 1017 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 16:44:08 EST
Subject: Re: [PATCH] gitweb: Fix shortlog only showing HEAD revision.
From: "J.H." <warthog19@eaglescrag.net>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@gmail.com>
In-Reply-To: <459EC16F.1070809@linuxtv.org>
References: <459C0232.3090804@linuxtv.org>
	 <20070103202555.GA25768@localhost>  <459EC16F.1070809@linuxtv.org>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 13:25:58 -0800
Message-Id: <1168032358.2505.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-05 at 16:21 -0500, Michael Krufky wrote:
> Robert Fitzsimons wrote:
> > My change in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6 had a small bug
> > found by Michael Krufky which caused the passed in hash value to be
> > ignored, so shortlog would only show the HEAD revision.
> > 
> > Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
> > ---
> > 
> > Thanks for finding this Michael.  It' just a small bug introducted by a
> > recent change I made.  Including John 'Warthog9' so hopefully he can add
> > this to the version of gitweb which is hosted on kernel.org.
> > 
> > Robert
> 
> Robert,
> 
> Thank you for fixing this bug so quickly.  I've noticed that the gitweb
> templates on kernel.org have changed at least once since you wrote this email to
> me... (I can tell, based on the fact that the git:// link has moved from the
> project column to a link labeled, "git" all the way to the right.)
> 
> Unfortunately, however, the bug that I had originally reported has not yet been
> fixed on the kernel.org www server.  Either the patch in question hasn't yet
> been applied to that installation, or it HAS in fact been applied, but doesn't
> fix the problem as intended.

Simple answer - it's sitting in my tree waiting for me to have enough
time to get back to gitweb.  There are several things in flight and I'm
not prepared to push them out in their current state.

So yes the problem is fixed, but it will probably be sometime this
weekend before it gets pushed out to the kernel.org servers.

> 
> Do you know which of the above is true?
> 
> Thanks again,
> 
> Mike Krufky
> 
> >  gitweb/gitweb.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index d845e91..2e94c2c 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -4423,7 +4423,7 @@ sub git_shortlog {
> >  	}
> >  	my $refs = git_get_references();
> >  
> > -	my @commitlist = parse_commits($head, 101, (100 * $page));
> > +	my @commitlist = parse_commits($hash, 101, (100 * $page));
> >  
> >  	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
> >  	my $next_link = '';
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

