Return-Path: <linux-kernel-owner+w=401wt.eu-S1030210AbWLTR1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWLTR1U (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWLTR1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:27:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:43651 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965152AbWLTR1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:27:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PFaQaiXSv0bn75VlgaNCMBDPEyZWL0mtSqfrl+636zj6YlMftkPwfsxXZle/0TUlbUm5iJthbChdJVicMPlNpC39PvolN2K3CI/KSmSs85i+qMJ1GqQGJyLE4Khd/cFXr4gAZ5PU3WtYRAhSO00SYnY1BnBnvRsDjFWkoTiwIjk=
Message-ID: <787b0d920612200927u61e08288o1728ff6433bd92b@mail.gmail.com>
Date: Wed, 20 Dec 2006 12:27:15 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: util-linux: orphan
Cc: kzak@redhat.com, hvogel@suse.de, olh@suse.de, hpa@zytor.com,
       linux-kernel@vger.kernel.org, arekm@maven.pl,
       util-linux-ng@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612201712190.15218@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <Pine.LNX.4.61.0612201712190.15218@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >> I've originally thought about util-linux upstream fork,
> >> but as usually an fork is bad step. So.. I'd like to start
> >> some discussion before this step.
> > ...
> >> after few weeks I'm pleased to announce a new "util-linux-ng"
> >> project. This project is a fork of the original util-linux (2.13-pre7).
> >
> > Well, how about giving me a chunk of it? I'd like /bin/kill please.
> > I already ship a nicer one in procps anyway, so you can just delete
> > the files and call that done. (just today I was working on a Fedora
> > system and /bin/kill annoyed me)
>
> How can you ship a "nicer" kill, given that its sole purpose is to accept
>
>   kill { -l | -t | {-s SIGNUM | -SIGNAME } somepid [morepids] }
>
> ?

I checked compatibility with Solaris, Tru64, probably a few BSDs,
and man pages of many others.

Fedora Core 5 doesn't seem to like this command:

/bin/kill -l 17 19

(which reminds me, I need to add sigqueue support and
maybe tgkill support)

> What about merging util-linux and procps?

How? Which way?

As I mentioned before, I was twice disappointed in missing
announcements of util-linux maintainership being up for grabs.
I certainly have a track record for keeping things stable.

Prior to me, procps has a history of being abandoned and
broken. Procps is a fork of the long-dead kmem-ps project.
Procps was then passed to someone who added color and
then disappeared. The prior maintainer picked up the old
code again, no doubt under influence of his employer Red Hat.
I rewrote much of it then, but had trouble getting in all of
my changes. Debian started using my code, which slowly
turned into a fork. Maintainership was passed to somebody
else, without even telling me. That person and his immediate
successor added numerous serious bugs. Inexperience with
the code and the lack of a test suite soon led to that group
being bogged down in problems. One by one, the various
Linux distributions switched over to my version of the code.

So as you may imagine, I'd be rather nervous about letting
procps get into that situation again. Bugs are yucky. Having
multiple committers and no testing is a sure path to ruin.
