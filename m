Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVJ2TiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVJ2TiH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVJ2TiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:38:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932123AbVJ2TiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:38:05 -0400
Date: Sat, 29 Oct 2005 12:37:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <4363CB60.2000201@pobox.com>
Message-ID: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org>
 <4363CB60.2000201@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2005, Jeff Garzik wrote:
> 
> Even so, it's easy, to I'll ask him to test 2.6.14, 2.6.14-git1, and
> (tonight's upcoming) 2.6.14-git2 (with my latest pull included) to see if
> anything breaks.

Side note: one of the downsides of the new "merge lots of stuff early in 
the development series" approach is that the first few daily snapshots end 
up being _huge_. 

So the -git1 and -git2 patches are/will be very big indeed.

For example, patch-2.6.14-git1 literally ended up being a megabyte 
compressed. Right now my diff to 2.6.14 (after just two days) is 1.6MB 
compressed.

Admittedly, some of it is due to things like the MIPS merge, but the point 
I'm trying to make is that it makes the daily snapshot diffs a lot less 
useful to people who try to figure out where something broke.

Now, I've gotten several positive comments on how easy "git bisect" is to 
use, and I've used it myself, but this is the first time that patch users 
_really_ become very much second-class citizens, and you can't necessarily 
always do useful things with just the tar-trees and patches. That's sad, 
and possibly a really big downside.

Don't get me wrong - I personally think that the new merge policy is a 
clear improvement, but it does have this downside.

			Linus
