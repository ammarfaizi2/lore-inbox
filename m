Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271871AbRHUV62>; Tue, 21 Aug 2001 17:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271874AbRHUV6T>; Tue, 21 Aug 2001 17:58:19 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:49933 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S271871AbRHUV6D>; Tue, 21 Aug 2001 17:58:03 -0400
Subject: Re: Entropy from net devices - keyboard & IDE just as 'bad' [was
	Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
From: Robert Love <rml@tech9.net>
To: Robert Love <rml@tech9.net>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <998430650.4293.33.camel@phantasy>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMCEDNDFAA.davids@webmaster.com>
	<606175155.998387452@[169.254.45.213]> 
	<9lu9ag$n5v$6@abraham.cs.berkeley.edu>  <998430650.4293.33.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.20.07.08 (Preview Release)
Date: 21 Aug 2001 17:57:15 -0400
Message-Id: <998431094.4293.46.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-08-21 at 17:50, Robert Love wrote:
><snip>
> 
> In theory, we dont need both SHA-1 hash and the entropy count.  They
> exist to pacify a theoretical weakness in each.
> 
> Now, my net device patch should only be enabled in situations where both
> you trust SHA-1 (and I think most do) and you trust that reading net
> devices yields the full amount of entropy.

'lil typo on my part.  actually, if you trust SHA-1, it does not matter
if your net devices give zero entropy, because the SHA-1 hash of the
read from /dev/random is still unpredictable.

the problem is if you both _dont_ trust SHA-1 and _fear_ there is
less-than-estimated entropy from net devices on your network.

per Alex Bligh's suggestion, the Configure wording of the next patch
will explain this.
 
-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

