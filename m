Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUKHShg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUKHShg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbUKHSgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:36:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6158 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261196AbUKHSfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:35:20 -0500
Date: Mon, 8 Nov 2004 19:34:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108183449.GC15077@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de> <20041108153436.GB9783@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <20041108175120.GB27525@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108175120.GB27525@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 06:51:20PM +0100, Andi Kleen wrote:
> On Mon, Nov 08, 2004 at 05:31:01PM +0100, Adrian Bunk wrote:
> > On Mon, Nov 08, 2004 at 05:19:35PM +0100, Andi Kleen wrote:
> > > > Rethinking it, I don't even understand the sprintf example in your 
> > > > changelog entry - shouldn't an inclusion of kernel.h always get it 
> > > > right?
> > > 
> > > Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str) transparently.
> > 
> > Which gcc is "Newer"?
> 
> I saw it with 3.3-hammer, which had additional optimizations in this 
> area at some point. Note that 3.3-hammer is widely used. I don't 
> know if 3.4 does it in the same way.

Is this a -hammer specific problem?
If yes, does a -no-builtin-sprintf fix it?

Or is the problem a missing #include <linux/kernel.h> at the top of 
include/linux/string.h?

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

