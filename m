Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUCUUgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUCUUgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:36:24 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:56197 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261296AbUCUUf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:35:59 -0500
Date: Sun, 21 Mar 2004 21:35:59 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040321203559.GA30361@wohnheim.fh-wedel.de>
References: <20040321181430.GB29440@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0403211159320.12699-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0403211159320.12699-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 March 2004 12:26:57 -0800, Davide Libenzi wrote:
> 
> Yes, at that time I preferred to fall back to the caller open(2) if any 
> error happened during the COW (a more picky implementation would simply 
> bounce an error to the application). Look BTW that there is a difference 
> between the error handling when you have an in-kernel solution or a 
> completely userspace solution. If you push this inside the kernel you have 
> at least to define a new open(2) flag and a new set of errors that might 
> arise when doing the COW. You are basically changing the open(2) API. You 
> have also to "teach" apps to use the new flag, since obviously you cannot 
> make COW a default behavior. The fl-cow approach let you define a set of 
> paths where you want COW to happen (in my case typically /usr/src/lk), and 
> only apps writing to hard-linked files inside such path gets COWed. The 
> open(2) API does not change. OTOH there is the LD_PRELOAD trick that is 
> weak alias dependent.

My "solution" to this paradox (leaving the interface unchanged, even
though cow is impossible without changes) is a new flag to files.  The
user has to manually set the flag and is now in charge of anything
that might break.  Scared?  Don't set the flag.

It is a compromise, just like yours.  Imo it is a little nicer, but
there just isn't any good solution anymore, 1967 would have been the
right time for that.

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
