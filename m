Return-Path: <linux-kernel-owner+w=401wt.eu-S932184AbXACXWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbXACXWM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbXACXWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:22:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45720 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932180AbXACXWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:22:10 -0500
Message-ID: <459C3A8B.4040206@sandeen.net>
Date: Wed, 03 Jan 2007 17:21:47 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fix memory corruption from misinterpreted bad_inode_ops
 return values
References: <459BF927.2020108@sandeen.net> <20070104101423.06bdd664.sfr@canb.auug.org.au>
In-Reply-To: <20070104101423.06bdd664.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi Eric,
> 
> On Wed, 03 Jan 2007 12:42:47 -0600 Eric Sandeen <sandeen@sandeen.net> wrote:
>> So here's the first stab at fixing it.  I'm sure there are style points
>> to be hashed out.  Putting all the functions as static inlines in a header
>> was just to avoid hundreds of lines of simple function declarations before
>> we get to the meat of bad_inode.c, but it's probably technically wrong to
>> put it in a header.  Also if putting a copyright on that trivial header file
>> is going overboard, just let me know.  Or if anyone has a less verbose
>> but still correct way to address this problem, I'm all ears.
> 
> Since the only uses of these functions is to take their addresses, the
> inline gains you nothing 

Hm, yes of course... my fingers just automatically type "static inline"
in header files I guess. :)

> and since the only uses are in the one file, you
> should just define them in that file.

Ok, will do.  That seems to be the consensus.

Thanks,

-Eric
