Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTDWPRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTDWPRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:17:19 -0400
Received: from [81.80.245.157] ([81.80.245.157]:15551 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264075AbTDWPRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:17:17 -0400
Date: Wed, 23 Apr 2003 17:29:14 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423152914.GM820@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423144857.GN354@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 10:48:58AM -0400, Ben Collins wrote:

> > As for 2.4.21, well, we want something pretty well tested. Will this
> > be the case with your new mega-patch ? I don't think so. The safest
> > is to go back to a version which worked. At least the bugs of that
> > version are known, which is not the case for the new version.
> 
> BTW, have you even tested the patch? I can almost guarantee is is more
> stable than what was in -pre7 (outside of the one small fix I had to
> apply for the IRM looping). The -pre7 code has loads of irq disabling
> problems and dead lock issues, not to mention the race conditions.
> 
> The problem you see with the irq disabling around kernel_thread() may
> not be there in -pre7, but that's only because the shared data with the
> thread was not protected from a race condition that causes an oops in
> some not-so-rare cases.

I confirm that your patch at least solves the initialisation issues.
I'll test later with some ieee devices and I'll report back if I found
other issues.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
