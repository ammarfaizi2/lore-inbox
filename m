Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263480AbRFTWBP>; Wed, 20 Jun 2001 18:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263567AbRFTWBF>; Wed, 20 Jun 2001 18:01:05 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:54794 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S263480AbRFTWAu>;
	Wed, 20 Jun 2001 18:00:50 -0400
Date: Wed, 20 Jun 2001 16:12:19 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: linux-kernel@vger.kernel.org
Cc: jjciarla@raiz.uncu.edu.ar, schoenfr@gaertner.DE
Subject: Re: IP_ALIAS in 2.4.x gone?
In-Reply-To: <Pine.LNX.4.10.10106201516470.12664-100000@clueserver.org>
Message-ID: <Pine.LNX.4.10.10106201608560.12664-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found the problem...

IP_ALIAS is no longer needed in the config.  I screwed up the init script
configs for it so it did not work as expected.

The documentation does not reflect that the alias behaviour is on by
default.

I will submit a patch for the docs that reflects this so others will not
get confused by that.

On Wed, 20 Jun 2001, Alan Olsen wrote:

> 
> Has the IP_ALIAS functionality been replaced by something else in the
> 2.4.x kernels?
> 
> Documentation/networking/alias.txt seems to imply that it still does, but
> the string IP_ALIAS does not exist anywhere else in the entire source
> tree. (Unless you count the default configs for non-i86 architectures.
> 
> There is a "virtual server" option in the kernel that ships with Redhat,
> but I assume that this is a patch for something Redhat specific.  (It is
> not an option in 2.4.5, unless I am missing something.)
> 
> How is binding multiple IPs to a single ethernet card *supposed* to be
> handled under 2.4.x?  If the IP_ALIAS option is no longer valid, then the
> alias.txt doc should be changed to reflect the new option.
> 
> Thanks!
> 
> alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
> Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
>  "All power is derived from the barrel of a gnu." - Mao Tse Stallman
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

