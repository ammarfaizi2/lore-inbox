Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269928AbUJGXco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269928AbUJGXco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269926AbUJGXce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:32:34 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:39860 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S269928AbUJGXay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:30:54 -0400
In-Reply-To: <20041007224640.GC7047@pclin040.win.tue.nl>
References: <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156727.31753.44.camel@localhost.localdomain> <001f01c4ac8b$35849710$161b14ac@boromir> <1097160628.31614.68.camel@localhost.localdomain> <20041007215834.GA7047@pclin040.win.tue.nl> <CE341A74-18B0-11D9-ABEB-000393ACC76E@mac.com> <20041007224640.GC7047@pclin040.win.tue.nl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EE2D21FC-18B8-11D9-ABEB-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: mmap specification - was: ... select specification
Date: Thu, 7 Oct 2004 19:30:53 -0400
To: Andries Brouwer <aebr@win.tue.nl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 07, 2004, at 18:46, Andries Brouwer wrote:
> The POSIX text is clear to me, and Linux is compliant.
> On the other hand, I have no idea what you try to say.

> On Thu, Oct 07, 2004 at 06:32:43PM -0400, Kyle Moffett wrote:
>
>>>> "References within the address range starting at pa and continuing
>>>> for len bytes to whole pages following the end of an object shall
>>>> result in delivery of a SIGBUS signal."

Reviewing this once more:

> References within the address range starting at pa and continuing for
> len bytes:
range = {pa ... pa+len};

> To whole pages following the end of an object:
range = {pa ... PAGE_ROUND_UP(pa+len)};

> shall result in delivery of a SIGBUS signal:
pa[ range[n] ]; => SIGBUS


This is clearly not what is meant

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


