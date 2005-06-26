Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVFZU6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVFZU6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFZU6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 16:58:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48588 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261311AbVFZU6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 16:58:35 -0400
Message-ID: <42BF16F6.601@pobox.com>
Date: Sun, 26 Jun 2005 16:58:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Hackers Guide to git (v3)
References: <42BCE80A.2010802@pobox.com> <200506251840.j5PIelGv012506@turing-police.cc.vt.edu>
In-Reply-To: <200506251840.j5PIelGv012506@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Sat, 25 Jun 2005 01:13:46 EDT, Jeff Garzik said:
> 
> 
>>Kernel Hackers' Guide to git
>>
>>
>>1) installing git
> 
> 
> A nice document.  Unfortunately, my brain is tiny, and there's some
> usage questions you don't cover, and I can't seem to figure out myself...
> 
> Let's say I've cloned Linus's git tree, and now I want to build a kernel
> that has Linus's stuff, the 'audit' tree that's (last I checked) located at
> kernel.org/pub/scm/linux/kernel/git/dwmw2/audit-2.6, and another tree (foobar-2.6).
> 
> 1) How do I do this merge?
> 
> 2) How do I handle if an audit-2.6 and foobar-2.6 patch conflict -
>    a) for right now...
>    b) so it gets it right the *next* time I pull both and there's a collision
>       (possibly between the next foobar-2.6 changeset and my modification of
>       the previous changeset's results to clean the conflict)

Just 'git pull $url' all into the same repo.  If git cannot auto-merge 
the changes together, it will spit out a conflict for you to manually 
merge.  You merge just like CVS or BK:  correct the code between 
'<<<<<<' and '>>>>>>'.


> Another (possibly even more important to me at the moment) usage question:
> 
> I have a non-git 2.6.12-mm1 tree. Given a Linus git tree and an audit-2.6 git
> tree, how do I create a tree that contains "2.6.12-mm1 plus additional
> audit-2.6 changes since Andrew cut -mm1"?  (I'm chasing a bug that was
> supposedly fixed in userspace audit-0.9.10, but is still borked for me in
> 0.9.13 - I'm suspecting the bugfix is dependent on a divergence between the
> Fedora kernel (basically 2.6.12-git5 for this discussion) and -mm1...)

That's a bit tougher, since Andrew doesn't keep his stuff in git.

	Jeff



