Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271868AbRHUVu6>; Tue, 21 Aug 2001 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271870AbRHUVui>; Tue, 21 Aug 2001 17:50:38 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:55046 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271869AbRHUVua>; Tue, 21 Aug 2001 17:50:30 -0400
Subject: Re: Entropy from net devices - keyboard & IDE just as 'bad' [was
	Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
From: Robert Love <rml@tech9.net>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9lu9ag$n5v$6@abraham.cs.berkeley.edu>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMCEDNDFAA.davids@webmaster.com>
	<606175155.998387452@[169.254.45.213]> 
	<9lu9ag$n5v$6@abraham.cs.berkeley.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.20.07.08 (Preview Release)
Date: 21 Aug 2001 17:50:41 -0400
Message-Id: <998430650.4293.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-08-21 at 14:29, David Wagner wrote:
> Alex Bligh - linux-kernel  wrote:
> >For clarity, I'm saying Robert's patch is GOOD, and those who are trying
> >to point out what I consider to be extremely theoretical weakness it
> >introduces into /dev/random (and then, only when config'd on), [...]
> 
> That's one place where we disagree.  Over-estimating entropy is not a
> theoretical weakness: this is something that real cryptographers get real
> worried about.  It's one of the easiest ways for a crypto system to fail.

Entirely agreed, but that is why we have SHA-1.  If we assume SHA-1 is
not crackable, then the entropy estimate is actually worthless.  It
exists because of the theoretical possibility of learning some state of
the pool from a given read.

In theory, we dont need both SHA-1 hash and the entropy count.  They
exist to pacify a theoretical weakness in each.

Now, my net device patch should only be enabled in situations where both
you trust SHA-1 (and I think most do) and you trust that reading net
devices yields the full amount of entropy.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

