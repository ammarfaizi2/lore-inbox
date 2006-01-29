Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWA2Kk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWA2Kk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 05:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWA2Kk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 05:40:26 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:52244 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750903AbWA2Kk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 05:40:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KhLT3L75PVNeyXE7/uPZrwW7MO6sC/BYsNeqbY1uO9ntNtsJg9l5ws3v6jsKe1ExdDtr76tk1mzcZ+5J8DRa9diFs0c+gs783V3Zk6CqImiK3zSuGy8rbSPYHrdzvru1fvoeNt79kLBZTzLSXTzY+mBB7U0rSatso5jJCpURFXQ=
Message-ID: <43DC9B86.2000200@gmail.com>
Date: Sun, 29 Jan 2006 18:40:06 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-fbdev-devel@lists.sourceforge.net, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       benh@kernel.crashing.org, linux-kernel@hansmi.ch
Subject: Re: [PATCH] fbdev: Fix usage of blank value passed to fb_blank
References: <20060127231314.GA28324@hansmi.ch>	<20060127.204645.96477793.davem@davemloft.net>	<43DB0839.6010703@gmail.com>	<200601282106.21664.ioe-lkml@rameria.de>	<43DC25EB.1040005@gmail.com> <20060129001832.4fe6fd7f.akpm@osdl.org>
In-Reply-To: <20060129001832.4fe6fd7f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Unfortunately, this may cause some userland breakage.  X should work.
>>  However, some apps may have been developed that uses the FB_BLANK constants
>>  (DirectFB?).  In these cases, they'll get a deeper blank level instead, so it
>>  probably won't affect them significantly.  A follow up patch that hides the 
>>  FB_BLANK constants may be worthwhile.
> 
> Would prefer to avoid any userland breakage.  Is this followup patch
> happening?

I'm still doing research on which major fb apps depend on the FB_BLANK constants, but
my guess is that the follow up patch is inevitable. We cannot avoid bending over
backwards for X :(

Tony
