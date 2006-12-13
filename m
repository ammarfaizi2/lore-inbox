Return-Path: <linux-kernel-owner+w=401wt.eu-S965013AbWLMQjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWLMQjb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWLMQjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:39:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3105 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965013AbWLMQjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:39:31 -0500
Date: Wed, 13 Dec 2006 17:39:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CodingStyle:  "kzalloc()" versus "kcalloc(1,...)"
Message-ID: <20061213163939.GJ3851@stusta.de>
References: <Pine.LNX.4.64.0612071912030.22957@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612071912030.22957@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 07:16:15PM -0500, Robert P. J. Day wrote:
> 
>   i just noticed that there are numerous invocations of kcalloc()
> where the hard-coded first arg of # elements is "1", which seems like
> an inappropriate use of kcalloc().
> 
>   the only rationale i can see is that kcalloc() guarantees that the
> memory will be set to zero, so i'm guessing that this form of
> kcalloc() was used before kzalloc() existed, or was used by folks who
> didn't know that kzalloc() existed.
> 
>   if a (zero-filled) single struct is being allocated, is it worth
> codifying that that allocation should use kzalloc() and not
> kcalloc(1,...)?

kcalloc() calls kzalloc(), so it doesn't matter at all which to use.

> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

