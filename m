Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWDEWWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWDEWWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWDEWWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:22:33 -0400
Received: from ns.suse.de ([195.135.220.2]:2696 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932107AbWDEWWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:22:32 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs / Novell Inc.
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] modules_install must not remove existing modules
Date: Thu, 6 Apr 2006 00:21:36 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200604052333.51085.agruen@suse.de> <20060405221229.GA8972@mars.ravnborg.org>
In-Reply-To: <20060405221229.GA8972@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604060021.37049.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 00:12, Sam Ravnborg wrote:
> The removal was introduced to get rid of old modules from an earlier
> build of the same kernel with potential more modules.
> I was obvious when I played with an allmodconfig kernel IIRC.

The in-tree modules all install below kernel/, so I don't see why removing the 
external modules directory (extra or whatever) is necessary for that. It 
might still be that there are other external modules 
below /lib/modules/$KERNELRELEASE, though.

> The usecase you have in mind is with external modules only?

Yes, with more than one set of them, each of which using modules_install.

> We could special case in that suation and avoid the removal.
>
> I see no way to detect when it is OK to remove or not, so in the
> principle of least suprise I prefer having the removal unconditional for
> normal kernel builds, and no removal for external modules.
>
> OK?

That would be okay for me, yes.

Thanks,
Andreas
