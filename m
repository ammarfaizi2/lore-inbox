Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWIGXAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWIGXAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbWIGXAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:00:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62412 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751634AbWIGXAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:00:44 -0400
Date: Fri, 8 Sep 2006 01:00:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060907230028.GB30916@elf.ucw.cz>
References: <20060907173449.GA24013@clipper.ens.fr> <E1GLPhz-0001T9-00@calista.eckenfels.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GLPhz-0001T9-00@calista.eckenfels.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-09-07 21:38:43, Bernd Eckenfels wrote:
> In article <20060907173449.GA24013@clipper.ens.fr> you wrote:
> > They wouldn't have to be marked: capabilities are inherited by
> > default, with my patch (as is the Unix tradition: euid=0 or {r,s}uid=0
> > are preserved upon execve()), normal processes have CAP_FORK and just
> > pass it on if you don't do something special to remove it.
> 
> The Problem with that is, that a program can be started with some priveldges
> without knowing it. Traditional programs only check for uid=0 and in that
> case refuse to do some things. A program might not expect to be able to do a
> priveldged action with not being uid=0.

But that is not a problem.

If attacker already has priviledge foo, he can just go use it. He does
not have to exec() poor program not expecting to get priviledge foo,
then abusing it.

...actually...

...what you say is a problem. You are right that capabilities should
be "sanitized" on every exec of suid/sgid program (not only suid
root).

Sanitized here means "all regular capabilities set, all others
cleared".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
