Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWHDAMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWHDAMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWHDAMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:12:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11282 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932289AbWHDAMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:12:24 -0400
Date: Fri, 4 Aug 2006 02:12:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: Userspace visible of 3 include/asm/ headers
Message-ID: <20060804001221.GM25692@stusta.de>
References: <20060803193952.GF25692@stusta.de> <20060803194410.GC16927@redhat.com> <44D26A8B.9040907@zytor.com> <20060803215230.GI25692@stusta.de> <44D28C0A.905@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D28C0A.905@zytor.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:51:38PM -0700, H. Peter Anvin wrote:
> Adrian Bunk wrote:
> 
> >
> >On different architectures, we have the following values for 
> >COMMAND_LINE_SIZE:
> >- 256
> >- 512
> >- 896
> >- 1024
> >- 4096
> >
> >What should be the common value?
> >4096?
> >
> >And I have a rough memory of some dependencies of COMMAND_LINE_SIZE and 
> >boot loaders. What exactly must be taken care of when increasing 
> >COMMAND_LINE_SIZE?
> >
> 
> It's architecture-dependent; it probably should be defined in something 
> like <asm/cmdline.h>.

OK, I did misunderstand you.
I tought you were saying it should be the same value for all 
architectures.

With the exception of frv (in param.h), COMMAND_LINE_SIZE is in setup.h 
on all architectures.

Do we want to move it to a different header, or simply make param.h a 
userspace header on all architectures?

> 	-hpa

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

