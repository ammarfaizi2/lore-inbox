Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVA0AQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVA0AQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVA0AQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:16:02 -0500
Received: from lakermmtao03.cox.net ([68.230.240.36]:14214 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262472AbVAZWMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:12:18 -0500
In-Reply-To: <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <56B00E32-6FE7-11D9-A93E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Bryn Reeves <breeves@redhat.com>,
       James Antill <james.antill@redhat.com>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: don't let mmap allocate down to zero
Date: Wed, 26 Jan 2005 17:12:16 -0500
To: linux-os@analogic.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 26, 2005, at 11:38, linux-os wrote:
> Does this mean that we can't mmap the screen regen buffer at
> 0x000b8000 anymore?

I believe the point of this is to ensure that *non*-MAP_FIXED
mmap calls won't use 0, IOW, it keeps things from accidentally
being mapped at 0 when the user didn't intend to, like shared
libs and such.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


