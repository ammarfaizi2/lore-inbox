Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbUKHQ45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUKHQ45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUKHQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:54:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49167 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261869AbUKHPfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:35:07 -0500
Date: Mon, 8 Nov 2004 16:34:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108153436.GB9783@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108134448.GA2456@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 02:44:49PM +0100, Andi Kleen wrote:

> > Can you still reproduce this problem?
> > If not, I'll suggest to apply the patch below which saves a few kB in 
> > lib/string.o .
> 
> I would prefer to keep it because there is no guarantee in gcc
> that it always inlines all string functions unless you pass
> -minline-all-stringops. And with that the code would
> be bloated much more than the few out of lined fallback
> string functions.

If I understand your changelog entry correctly, this wasn't the problem
(the asm string functions are "static inline").

Rethinking it, I don't even understand the sprintf example in your 
changelog entry - shouldn't an inclusion of kernel.h always get it 
right?

> Even if it works for you with your configuration it's just by luck.

The two configurations I tried are one configuration with _everything_ 
except modules enablesd, and the other was _everything_ modular.

That's why I'd like to have an example where it fails to understand the 
problem.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

