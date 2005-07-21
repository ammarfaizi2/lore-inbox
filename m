Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVGUQ5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVGUQ5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 12:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGUQ5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 12:57:33 -0400
Received: from smtpout.mac.com ([17.250.248.47]:51956 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261809AbVGUQ53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 12:57:29 -0400
In-Reply-To: <20050720174521.73c06bce.pj@sgi.com>
References: <20050714011208.22598.qmail@science.horizon.com> <FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com> <Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr> <20050720174521.73c06bce.pj@sgi.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3FC51285-941F-48B6-B5A9-1BBE95CCD816@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux@horizon.com,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: kernel guide to space
Date: Thu, 21 Jul 2005 12:57:16 -0400
To: Paul Jackson <pj@sgi.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 20, 2005, at 20:45:21, Paul Jackson wrote:
> drivers/scsi/BusLogic.c:
>
>   %2d     %5d %5d %5d    %5d %5d %5d       %5d %5d %5d\n",  
> TargetID, TargetStatistics[TargetID].CommandAbortsRequested,  
> TargetStatistics[TargetID].CommandAbortsAttempted, TargetStatistics 
> [TargetID].CommandAbortsCompleted, TargetStatistics 
> [TargetID].BusDeviceResetsRequested, TargetStatistics 
> [TargetID].BusDeviceResetsAttempted, TargetStatistics 
> [TargetID].BusDeviceResetsCompleted, TargetStatistics 
> [TargetID].HostAdapterResetsRequested, TargetStatistics 
> [TargetID].HostAdapterResetsAttempted, TargetStatistics 
> [TargetID].HostAdapterResetsCompleted);

Ugh!!!  From CodingStyle (although this is not always followed):
> The limit on the length of lines is 80 columns and this is a hard  
> limit.
> Statements longer than 80 columns will be broken into sensible chunks.
> Descendants are always substantially shorter than the parent and  
> are placed
> substantially to the right.  The same applies to function headers  
> with a long
> argument list.  Long strings are as well broken into shorter strings.
> [example relevant to the above code snipped]


Also:
> C is a Spartan language, and so should your naming be.  Unlike  
> Modula-2 and
> Pascal programmers, C programmers do not use cute names like
> ThisVariableIsATemporaryCounter.  A C programmer would call that  
> variable
> "tmp", which is much easier to write, and not the least more  
> difficult to
> understand.
>
> [...] mixed-case names are frowned upon [...]

*cough* TargetStatistics[TargetID].HostAdapterResetsCompleted *cough*

I suspect linus would be willing to accept a few cleanup patches for the
BusLogic.c file.  Perhaps even one that renames BusLogic.c to buslogic.c
like all the other files in the source tree, instead of using nasty
StudlyCaps all over :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


