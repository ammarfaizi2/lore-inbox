Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVLTQnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVLTQnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVLTQnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:43:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43276 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751126AbVLTQnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:43:18 -0500
Date: Tue, 20 Dec 2005 17:43:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Light-weight dynamically extended stacks
Message-ID: <20051220164316.GG6789@stusta.de>
References: <20051219001249.GD11856@waste.org> <20051219183604.GT23349@stusta.de> <20051220002759.GE3356@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220002759.GE3356@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 06:27:59PM -0600, Matt Mackall wrote:
>...
> So why am I raising this idea now at all? Because I think Neil's patch
> is too clever and too specific to block layer stacking and I'd rather
> have a more general solution. Block is by no means the only part of
> the system that allows nesting and pathological combinations surely
> still exist. And will be introduced in the future.
> 
> Also note that my approach might make it reasonable to use one-page
> stacks everywhere, not just on x86.
>...

I'm really looking forward to seeing your patch.

It will e.g. be interesting to measure whether there'll be any 
performance impact.

And since after this patch driver authors might become more sloppy with 
stack usage since there's no longer a hard limit, it will be especially 
interesting to see how you'll implement ensuring that there are no 
additional stack usages > 1 kB between two invocations of you check 
function, because otherwise your patch won't work reliable.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

