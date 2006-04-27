Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWD0FFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWD0FFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 01:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWD0FFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 01:05:01 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:63700 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S964918AbWD0FFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 01:05:00 -0400
Date: Wed, 26 Apr 2006 23:04:59 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de,
       ralf@linux-mips.org, paulus@samba.org, schwidefsky@de.ibm.com,
       lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, ysato@users.sourceforge.jp
Subject: Re: [PATCH] Handle CONFIG_LBD and CONFIG_LSF in one place
Message-ID: <20060427050459.GB29147@parisc-linux.org>
References: <20060419140540.GK24104@parisc-linux.org> <20060426183442.78e40e3b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426183442.78e40e3b.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 06:34:42PM -0700, Andrew Morton wrote:
> Matthew Wilcox <matthew@wil.cx> wrote:
> >
> >  CONFIG_LBD and CONFIG_LSF are spread into asm/types.h for no particularly
> >  good reason.  Centralising the definition in linux/types.h means that arch
> >  maintainers don't need to bother adding it, as well as fixing the problem
> >  with x86-64 users being asked to make a decision that has absolutely no
> >  effect.  The H8/300 porters seem particularly confused since I'm not aware
> >  of any microcontrollers that need to support 2TB filesystems these days.
> 
> x86_64:
> 
> include/linux/types.h:137: error: conflicting types for 'sector_t'
> include/asm/types.h:51: error: previous declaration of 'sector_t' was here

is the conflicting patch available somewhere so i can put a patch in for
it?  basically, you just need to delete the typedefs for sector_t and
blkcnt_t, just like i've done for the other architectures.
