Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbVKEHxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbVKEHxF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbVKEHxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:53:05 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:14153 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751451AbVKEHxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:53:04 -0500
Date: Sat, 5 Nov 2005 08:53:03 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fix remaining missing includes
In-Reply-To: <20051104232954.6145d309.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511050841310.8826@gans.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0511041746470.4856@gans.physik3.uni-rostock.de>
 <20051104232954.6145d309.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2005, Andrew Morton wrote:

> Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> >
> >  /* Encode and de-code a swap entry */
> >  @@ -464,6 +464,7 @@ static inline int ptep_test_and_clear_di
> >   
> >   extern spinlock_t pa_dbit_lock;
> >   
> >  +struct mm_struct;
> 
> Generally, it's better to put these forward struct declarations right at
> the top of the header file (after the nested includes).
> 
> Because if someone comes along later and adds some code which uses
> mm_struct at line 300, he's going to say a rude word and then add a second
> forward declaration at line 299, and we end up with two of them.  Or he's
> more awake and he just moves your declaration.  Either way, putting it at
> the top of the file eliminates the problem.

I was unsure how to handle this and decided to stick with the style of 
each file for now as I wanted the patch to be minimally intrusive.
I.e., if the file had forward declarations right in front of their use, I 
did it that way. If it had them at the top (or didn't have any, but I 
might have decided wrong on some of these), I put them there.

BTW this mostly came up within architecure specific files and was similar 
for each arch, so it seems to reflect their maintainers taste...

> 
> A followup patch sometime would be nice..
> 

Sure.
But it will take some days as I feel quite exhausted from getting the 
previous patch to work and want to reserve my spare time for any problems 
these patches bring up.

Thanks for your advice!

Tim
