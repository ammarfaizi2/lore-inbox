Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVAGUIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVAGUIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVAGUGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:06:02 -0500
Received: from waste.org ([216.27.176.166]:57802 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261581AbVAGUFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:05:16 -0500
Date: Fri, 7 Jan 2005 12:05:00 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, ast@domdv.de, rlrevell@joe-job.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       joq@io.com
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107200500.GX2940@waste.org>
References: <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <1104898693.24187.162.camel@localhost.localdomain> <20050104215010.7f32590e.akpm@osdl.org> <20050105120601.GA8730@mail.13thfloor.at> <20050107011309.GB2995@waste.org> <1105062723.17166.319.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105062723.17166.319.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 01:55:09AM +0000, Alan Cox wrote:
> On Gwe, 2005-01-07 at 01:13, Matt Mackall wrote:
> > You can't fix them without changing the semantics for existing users
> > in ways they didn't expect. It could be done with a new personality flag,
> > but..
> 
> I disagree. At the most trivial you could just add another 32bits of
> sticky capability that are never touched by setuid/non-setuidness and
> represent additional "user" (or more rightly session) abilities to do
> limited overrides

I think we're referring to different brokenness. The problems I see
are with the semantics of inheritance of capabilities which make
wrapping applications painful. Those can't be changed without creating
holes in existing apps so the general utility of caps is limited.

-- 
Mathematics is the supreme nostalgia of our time.
