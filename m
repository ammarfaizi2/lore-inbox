Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265459AbTFSMDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTFSMDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:03:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18148 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265459AbTFSMDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:03:39 -0400
Date: Thu, 19 Jun 2003 14:17:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, akpm@zip.com.au, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
Message-ID: <20030619121732.GQ29247@fs.tum.de>
References: <20030613011906.8BAD92C23B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613011906.8BAD92C23B@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 11:03:43AM +1000, Rusty Russell wrote:
> Argh, bogus line pasted into Makefile turned up in patch.
> 
> This should be better...
>...
> +# Needs gcc 3.3 or above to understand max-inline-insns-auto.
> +INLINE_OPTS	:= $(shell $(CC) -o /non/existent/file -c --param max-inline-insns-auto=0 -xc /dev/null 2>&1 | grep /non/existent/file >/dev/null && echo -finline-functions --param max-inline-insns-auto=0)
>...

You have to add a -Wno-unused-function or you'll get a warning for every
eliminated function.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

