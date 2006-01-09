Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWAIEe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWAIEe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWAIEe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:34:29 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:49073 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751262AbWAIEe2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:34:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kbULiWnHtXsuB7VSscYoIn6PZjUUHUt5gOen6OmMFCRdc+dOfkG479+Aj5OpZjgNv62TOfhesV1MRdqNawX/yQ4lbuetwlvwrmmSGGTCI0VOTv3wr5+hU3KDiLjjGjjiAol5S65jClW+8UYSrRrCuBQ6Oi6jmBh531TcYdpSNZc=
Message-ID: <46a038f90601082034g2865b26ftc344c599e29a4655@mail.gmail.com>
Date: Mon, 9 Jan 2006 17:34:25 +1300
From: Martin Langhoff <martin.langhoff@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Cc: Adrian Bunk <bunk@stusta.de>, "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
	 <20060108230611.GP3774@stusta.de>
	 <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> And then do
>
>         git-rebase linus
>
> to rebase your development branch to mine.
>
> THIS is what "rebase" is for. It sounds like what you really want to do is
> not have a development branch at all, but you just want to track my tree
> and then keep track of a few branches of your own. In other words, you
> don't really have a "real" branch - you've got an odd collection of
> patches that you really want to carry around on top of _my_ branch. No?

FWIW, I determine whether I should rebase or merge based on

 + Whether the branch/head I maintain is public. For public repos, I
*must* merge carefully as rebase "rewinds" the head and that makes a
mess of any repositor tracking me.

 + Whether the changes on my both sides are significant, and it is
semantically meaningful to have a merge. If either side had just a
couple of minor commits, rebase makes life a lot easier down the path.
If both side clearly saw parallel development, it is more sincere to
merge and let that be recorded.

 + If my attempt to rebase leads to any non-trivial conflicts or
co-dependencies, then I definitely cancel the rebase and merge.

> Now, in this model, you're not really using git as a distributed system.

I'd argue that it is not about distributed or not. It's all in what
you want to record in your history. As such, it is a communication
device -- and I want to make effective use of it. I guess the question
I ask myself is: what will communicate what's happened here most
clearly? What will be useful for people to read? In that context, a
white-lie here and there simplifying the history a bit where it's not
interesting counts as a good thing.

cheers,


martin
