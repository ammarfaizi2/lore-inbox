Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271226AbRHXMpY>; Fri, 24 Aug 2001 08:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271242AbRHXMpP>; Fri, 24 Aug 2001 08:45:15 -0400
Received: from 20dyn245.com21.casema.net ([213.17.90.245]:33298 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S271226AbRHXMpK>; Fri, 24 Aug 2001 08:45:10 -0400
Message-Id: <200108241245.OAA31998@cave.bitwizard.nl>
Subject: Re: Swap size for a machine with 2GB of memory
In-Reply-To: <200108200008.AAA157827@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl"
 at "Aug 20, 2001 00:08:40 am"
To: Andries.Brouwer@cwi.nl
Date: Fri, 24 Aug 2001 14:45:22 +0200 (MEST)
CC: ebiederm@xmission.com, esr@thyrsus.com, sct@redhat.com, gars@lanm-pc.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     From: ebiederm@xmission.com (Eric W. Biederman)
>     Date:     19 Aug 2001 14:49:23 -0600
> 
>     "Eric S. Raymond" <esr@thyrsus.com> writes:
> 
>     > The Red Hat installation manual claims that the size of the
>     > swap partition should be twice the size of physical memory,
>     > but no more than 128MB.
>     > 
>     > Should I believe the above formula?
> 
> You give two statements. The 128 MB bound was claimed by Microsoft
> and we screamed loudly that that was a lie - now it is claimed
> by both SuSE and RedHat. Funny.
> No, the bound is not 128 MB. See mkswap(8).

I think that red hat means: 

	recoomended swap (machine) = min (128M, 2 * RAM(machine));

My personal recommendation is: 

	recoomended swap (machine) = 2 * RAM(machine);
           (unless you know what you're doing). 

I run three machines with 0Mb swap: I know what I'm doing. If you know
you're going to run VERY VERY large simulations which have sort of
linear memory access patterns, it may pay to have LOTS more swap than
normally recommended.

Also, You spend just a few percent on "recommended swap" in relation
to what you just spent on "RAM (machine)". So even if you're never
going to use it, it's still usefull.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
