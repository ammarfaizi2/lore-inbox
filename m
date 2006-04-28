Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWD1Ldq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWD1Ldq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWD1Ldq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:33:46 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:45238 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965110AbWD1Ldq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:33:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=4Y+USFw97dSZljSXttWdgcw11ZcXuZcOh+1S2dQod+ORrLhF5pX5+NNGUE998pCShNOPjCOB3b/d8SlYJnpwozaL+PRB9UHCWAfVP1nrtWUrVMryrzTwYg4UEvXp2pXq/ogN0sZb2R7EWUCPQwMBmNglsvyaaLqZoxVgBq0JmaU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Date: Fri, 28 Apr 2006 13:33:40 +0200
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> <m1d5feotur.fsf@ebiederm.dsl.xmission.com> <20060426180110.GB8142@ccure.user-mode-linux.org>
In-Reply-To: <20060426180110.GB8142@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281333.41358.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 20:01, Jeff Dike wrote:
> On Wed, Apr 19, 2006 at 02:25:00AM -0600, Eric W. Biederman wrote:

> > In the case of migration the ugly case to properly handle is the
> > monotonic timer.   That needs an offset yet it is absolutely forbidden
> > to provide that offset from the inside.  So this is the one namespace
> > that I think is inappropriate to use sys_unshare to create.
> > We need a system call so that we can specify the minimum or the
> > starting monotonic time base.

> For migration, it looks like the container will have to specify the
> time base at creation so that everything in it will have a consistent
> view of time if they get moved around.

> So, maybe it belongs in clone as a "backwards" flag similar to
> CLONE_NEWNS.

I must note that currently every (?) flag allowed for unshare is also allowed 
for clone, so you need to do that anyway.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
