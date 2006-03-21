Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWCUTcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWCUTcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWCUTcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:32:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932429AbWCUTca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:32:30 -0500
Date: Tue, 21 Mar 2006 11:32:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
In-Reply-To: <1142968537.4749.96.camel@praia>
Message-ID: <Pine.LNX.4.64.0603211126290.3622@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org> 
 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>  <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
  <1142962995.4749.39.camel@praia>  <Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
  <1142965478.4749.58.camel@praia>  <Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
 <1142968537.4749.96.camel@praia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Mauro Carvalho Chehab wrote:
> 
> Weird, I can't see all those stuff here. It shows something like
> (running from master copy at kernel.org):

I just did the raw output, so my output was from

	git show --pretty=fuller -r e338b7

which isn't the default, but it's useful if you want to see both committer 
and author information (and the raw format is just because I wasn't 
interested in the diff itself, just looking at how many files where 
changed).

> So, after the merging message, I have a normal diff with:
> 
>  179 files changed, 1274 insertions(+), 785 deletions(-)

Yeah, we're talking about the same commit.

> Seeming all perfect from my knowledge about git.

It's a perfectly good commit. BUT IT IS NOT A MERGE, AND IT IS NOT A DIFF 
THAT I WANT TO SEE COMING IN FROM AN OUTSIDE TREE!

Basically, in the DVB tree you have absolutely _no_ business in "merging" 
work from my tree as a patch, especially when the patch you merge has 
absolutely zero to do with DVB. You just applied a 5000-line patch to the 
tree, with no merge message other than "Merge from Linus tree", and no 
attribution about what the f*ck was merged, and why.

THAT is the part I'm unhappy with. The git tree is not "corrupt" from a 
technical standpoint (it passes fsck). It's "corrupt" because it contains 
a patch that shouldn't be there, that is mis-attributed, and that 
incorrectly claims to be a merge when it isn't - it's just a random patch 
generated against my tree.

		Linus
