Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVEJBEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVEJBEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 21:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVEJBEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 21:04:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:26012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbVEJBEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 21:04:48 -0400
Date: Mon, 9 May 2005 18:04:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DVB patch 00/37] DVB updates for 2.6.12-rc4
Message-Id: <20050509180411.6cff1941.akpm@osdl.org>
In-Reply-To: <20050508184229.957247000@abc>
References: <20050508184229.957247000@abc>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach <js@linuxtv.org> wrote:
>
> Hi Andrew,
> 
> here are a bunch of patches from linuxtv.org CVS. Nothing
> exciting, just bugfixes, cleanups and support for a number
> of new card variants.

Do you view this as 2.6.12 material?

> One hunk from my previous patchset didn't make it into
> 2.6.12-rc4, but still lingers somewhere in rc3-mm3,
> thus the "make dvb_class static" patch will be rejected
> when applying to -rc3-mm3:
> dvb-core/dvbdev.c from http://lkml.org/lkml/2005/3/21/321

Yes, that fix seems to have been made upstream somewhere, so I'll drop that
patch.

I notice that Greg's tree changes dvb_class to be of type class_simple, so
there may be interactions between your stuff and
gregkh-01-driver-gregkh-driver-022_class-11-drivers.patch.  We'll see. 
(Warning, Greg's patch names tend to change, but it'll be something like
that).

I notice you have a lot of things like:

  Switch analog output of the Crystal sound chip to left/stereo/right mode.
  This will fix problems with some (most?) channels which do not encode 2-channel
  audio correctly. (Oliver Endriss)

In future, please try to gather Signed-off-by: lines for these
contributions, thanks.

