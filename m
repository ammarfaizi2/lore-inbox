Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVFWFRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVFWFRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVFWFRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:17:03 -0400
Received: from mail.dvmed.net ([216.237.124.58]:946 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262390AbVFWFQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:16:38 -0400
Message-ID: <42BA45B1.7060207@pobox.com>
Date: Thu, 23 Jun 2005 01:16:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com> <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> 	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/
> 
> See? What's your complaint with just doing that?

No complaint with that operation.  The complaint is that it's an 
additional operation.  Re-read what Greg said:

> Is there some reason why git doesn't pull the
> tags in properly when doing a merge?  Chris and I just hit this when I
> pulled his 2.6.12.1 tree and and was wondering where the tag went.

Multiple users -- not just me -- would prefer that git-pull-script 
pulled the tags, too.

Suggested solution:  add '--tags' to git-pull-script 
(git-fetch-script?), which calls
	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/


> You seem to not realize that "all tags" is a nonsensical statement in a 
> distributed system.
> 
> If you want to have a list of official tags, why not just do exactly that? 
> What's so hard with saying "ok, that place has a list of 'official' tags, 
> let's fetch them".

I know how tags work, and I like the new flexibility above and beyond BK.

Kernel hackers are surprised when the tags aren't pulled, along with the 
objects.  BK and CVS trained us that tags came with the repo, no 
additional steps needed.  Why not give us the OPTION of working like 
we've always worked?

Let the kernel hacker say "yes, I really do want to download the tags 
Linus publicly posted in linux-2.6.git/refs/tags" because this was a 
common operation in the previous workflow, a common operation that we 
-made use of-.

	Jeff


