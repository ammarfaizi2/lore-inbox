Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVFWFgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVFWFgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVFWFgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:36:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:13234 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262085AbVFWFfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:35:46 -0400
Message-ID: <42BA4A29.7030601@pobox.com>
Date: Thu, 23 Jun 2005 01:35:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Adam Kropelin <akropel1@rochester.rr.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org> <42BA18AF.2070406@pobox.com> <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org> <07be01c577a7$05108660$03c8a8c0@kroptech.com> <Pine.LNX.4.58.0506222146460.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506222146460.11175@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The problem I have with "git commit" committing everything dirty by
> default is that it encourages exactly the wrong kind of behaviour, ie the 
> "commit it all in one go without thinking about it".

100% agreed


> And "git status" really isn't that hard to type, and it will tell you 
> exactly what you've already marked for commit, and what you have dirty in 
> the tree but isn't marked for commit yet.

Having found about it recently, 'git status' is quite useful.


> So I think the "git commit <file-list>" thing is very convenient, but it's
> convenient exactly because it's concise yet still precise and doesn't 
> encourage the "just commit whatever random dirty state I have right now" 
> mentality.
> 
> And if you have more than a few files dirty in your tree, I really think
> it's much better to do "git status" and think about it a bit and select
> the files you do want to commit than it is to just do "git commit" and let
> it rip.

For me at least, providing a file list is a pain, because I am so 
precise [read: obsessive] about keeping an otherwise clean working dir 
:)  Except in rare occasions, I know precisely that the changes in the 
working dir comprise 100% of what I plan to commit.

Locally I have scripted

      git-diff-cache -p HEAD | diffstat -p1 | awk '{print $1}' > /tmp/lst
      git-update-cache `cat /tmp/lst`

because of this.

[again, clearly doesn't work with remove/add/mode change]


> Now, I could well imagine adding an "--all" flag (and not even allow the 
> shorthane version) to both git-update-cache and "git commit". So that you 
> could say "commit all the dirty state", but you'd at least have to think 
> about it before you did so.

That's pretty much what I suggested when I said

	git commit --figure-out-for-me-what-files-changed

:)

So I certainly agree there.

	Jeff



