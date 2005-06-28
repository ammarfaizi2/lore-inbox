Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVF1MSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVF1MSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVF1MSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:18:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57539 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261441AbVF1MSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:18:17 -0400
Date: Tue, 28 Jun 2005 14:16:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] i386: enable REGPARM by default
Message-ID: <20050628121623.GK4410@suse.de>
References: <20050624200916.GJ6656@stusta.de> <200506251046.22944.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506251046.22944.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25 2005, Denis Vlasenko wrote:
> On Friday 24 June 2005 23:09, Adrian Bunk wrote:
> > This patch should _not_ go into Linus' tree.
> > 
> > At some time in the future, we want to unconditionally enable REGPARM on 
> > i386.
> > 
> > Let's give it a bit broader testing coverage among -mm users.
> > 
> > This patch:
> > - removes the dependency of REGPARM on EXPERIMENTAL
> > - let REGPARM default to y
> > 
> > This patch assumes that people who use -mm are willing to test some more 
> > experimental features.
> > 
> > After this patch, REGPARM is still a config option users can disable.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Jens Axboe had hit an obscure bug with regparm just yesterday.
> It happened for him with gcc 3.3.5.
> 
> I have a preprocessed .c file which allows to reporduce this.
> For me, gcc 3.3.6 is okay. need to build 3.3.5 and test.
> 
> Meanwhile, maybe we shall prohibit regparm if gcc <=3.3.6 or 3.4?

It triggered without regparm as well, so I don't think that is to blame
here.

-- 
Jens Axboe

