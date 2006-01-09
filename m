Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWAIVXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWAIVXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWAIVXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:23:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33979 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750716AbWAIVXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:23:50 -0500
Message-ID: <43C2D45B.2050704@sgi.com>
Date: Mon, 09 Jan 2006 15:23:39 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org> <43C2CFBD.8040901@sgi.com> <20060109212005.GC14477@mars.ravnborg.org>
In-Reply-To: <20060109212005.GC14477@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Jan 09, 2006 at 03:03:57PM -0600, Eric Sandeen wrote:
>  
> 
>>Out of curiosity, what's the reason to drop VERSION & PATCHLEVEL... seems 
>>handy if you have a common body of code that needs to build for various 
>>kernels, with various Makefiles to suit.  As above. :)
> 
> The kernel is supposed to hold the code for the kernel - not a lot of
> backward compatibiliy cruft.

Understood, and it makes sense to yank that compat cruft from kernel.org codebases.

But it seems useful for projects outside the kernel which would like to know 
which kernel they are building against, as far as the build system goes.  I've 
seen a few drivers out there that try to keep building for both 2.4 & 2.6.

I guess for 2.4 & 2.6, the same can be accomplished by using Makefile and 
Kbuild for 2.4 and 2.6....

Maybe you can export it only if KBUILD_EXTMOD is set :)

Thanks,
-Eric
