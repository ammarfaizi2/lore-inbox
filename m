Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWDSKCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWDSKCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 06:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDSKCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 06:02:01 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30100 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750872AbWDSKCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 06:02:01 -0400
Date: Wed, 19 Apr 2006 12:01:45 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-acpi@vger.kernel.org,
       linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] -mm: acpi idle __read_mostly and de-init static var
In-Reply-To: <20060418233041.272264b6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604191144380.32445@scrub.home>
References: <20060418190045.GA25749@rhlx01.fht-esslingen.de>
 <20060418233041.272264b6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Apr 2006, Andrew Morton wrote:

> Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> >
> > - don't remove static init value of nocst and bm_history
> >    since __read_mostly may be special
> >    (see e.g. http://www.ussg.iu.edu/hypermail/linux/kernel/0010.0/0771.html)
> > 
> 
> hm, that was six years ago.  I'm vaguely surprised that the initialisation
> was needed even then.  It isn't needed now.  Or if it is, we need to find
> out why and fix it.

I guess 2.7.2 was still a valid compiler then. :)
All later versions don't behave like this, although it's still documented 
like this: http://gcc.gnu.org/onlinedocs/gcc/Variable-Attributes.html

bye, Roman
