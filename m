Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVFWCVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVFWCVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVFWCS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:18:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:38577 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261977AbVFWCQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:16:12 -0400
Message-ID: <42BA1B68.9040505@pobox.com>
Date: Wed, 22 Jun 2005 22:16:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com> <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
>>With BK, tags came with each pull.  With git, you have to go "outside 
>>the system" (rsync) just get the new tags.
> 
> 
> You don't have to use rsync, and you don't have to go outside the system. 
> That was my point: you can use "git-ssh-pull" to pull the tags.

OK, understood.


> But yes, you have to explicitly ask for them by name, ie the other side 
> has to let you know: "Oh, btw, I created a 'xyz' tag for you". And having 
> another helper script to hide the details of how git-*-pull handles tags 
> is obviously also a good idea, although it's pretty low on my list of 
> things to worry about.

The problem is still that nothing says "oh, btw, I created 'xyz' tag for 
you" AFAICS?

IMO the user (GregKH and me, at least) just wants to know their set of 
tags and heads is up-to-date on local disk.  Wants to know what tags are 
out there.  It's quite annoying when two data sets are out of sync 
(.git/objects and .git/refs/tags).

Asking for the tag by name isn't useful at all, in that regard, because 
that requires that the user already know what tags are available.  To 
get that info, one must use rsync, gitweb, or a subscription to Psychic 
Friends Network.

	Jeff


