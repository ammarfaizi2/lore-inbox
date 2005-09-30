Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbVI3SOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVI3SOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVI3SOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:14:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932560AbVI3SOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:14:30 -0400
Date: Fri, 30 Sep 2005 11:14:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated
In-Reply-To: <7v64si4von.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.64.0509301112100.3378@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
 <433D1E5D.20303@pobox.com> <7v64si4von.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Junio C Hamano wrote:
> 
> I suspect the version Linus posted has a funny interaction with
> 'git-pull'; 'git pull --tags' by mistake, or intentionally to
> file a bug report to annoy me ;-), would create an Octopus out
> of those tags, if I am not mistaken.

Hey, even more impressive is "git pull --all", which will happily try to 
create an octopus of every single ref available at the other end.

Now, I think that octopus merges in _general_ are likely to be driver 
error, and that it might make sense to have a separate flag to enable 
them in the first place. That would solve the confusion..

So then you could do

	git pull --all --octopus xyzzy

if you _really_ meant to do that. 

		Linus
