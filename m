Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWHIXUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWHIXUi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWHIXUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:20:38 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:34954
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751434AbWHIXUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:20:37 -0400
Message-ID: <44DA6DBE.6040907@lsrfire.ath.cx>
Date: Thu, 10 Aug 2006 01:20:30 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Chuck Ebbert <76306.1226@compuserve.com>, Pavel Machek <pavel@suse.cz>,
       Josh Boyer <jwboyer@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
References: <200608091749_MC3-1-C796-5E8D@compuserve.com> <20060809220048.GE3691@stusta.de> <20060809221854.GA15395@kroah.com>
In-Reply-To: <20060809221854.GA15395@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH schrieb:
> On Thu, Aug 10, 2006 at 12:00:49AM +0200, Adrian Bunk wrote:
>> On Wed, Aug 09, 2006 at 05:45:53PM -0400, Chuck Ebbert wrote:
>>> Umm, is there some place we can check to see what you've applied?
>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> 
> No, I would not use the main git tree to queue patches up.  What happens
> when you want to rip the middle one out because in review it turns out
> that it is incorrect?

You can have multiple branches in one git repository.  E.g. git's own
repository has a "master" branch containing all committed changes, a
"next" branch which is similar to a release candidate and is regularly
merged back into "master" if ready, and a "pu" branch which contains the
more experimental stuff.  The latter doesn't even have a continuous history.

And it has other branches containing different stuff, e.g. "man" is a
special branch containing the generated manpages.  You could also have
topic branches or one branch per submitter, or whatever.

> Please use a quilt tree of patches instead, and then only commit the
> patches when you do a release.  It's much simpler that way.

There's even a quilt clone based on git (http://www.procode.org/stgit/).
 I have never used it, though, so I can't comment on it.

That said, it's a good idea to keep the master branch continuous, i.e.
never delete it or reset it to some previous commit.  So, as you
suggest, have a staging area for patches and only commit the good ones
to your master branch.  You can use a branch in the same repo as staging
area, though.

You can do quite a lot of different things with just one git repository.
 :-D

René
