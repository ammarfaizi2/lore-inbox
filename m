Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVKWTGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVKWTGH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVKWTGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:06:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:9953 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932209AbVKWTGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:06:01 -0500
Date: Wed, 23 Nov 2005 13:02:59 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Add support for building uImages
In-Reply-To: <20051123185523.GC8336@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0511231253050.4255-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Sam Ravnborg wrote:

> On Wed, Nov 23, 2005 at 12:43:15PM -0600, Kumar Gala wrote:
> > +
> > +$(obj)/uImage: $(obj)/vmlinux.gz
> > +	$(Q)rm -f $@
> > +	$(call if_changed,uimage)
> > +	@echo -n '  Image: $@ '
> > +	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
> 
> The above is suboptimal. The $(call if_changed,uimage) will execute
> $(cmd_uimage) if 1) prerequisites has changed or 2) the command to execute
> has changed.
> In the above case 1) is always true, otherwise we would not reach the
> statement. So change it to $(call cmd,uimage) is the correct way.
> 
> The 'bug' is also present in ppc/boot/images

thanks.  I'll send a follow up patch to fix both cases.

- kumar

