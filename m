Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWCVGLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWCVGLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWCVGLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:11:51 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:36067 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750807AbWCVGLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:11:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][3/3] mm: swsusp post resume aggressive swap prefetch
Date: Wed, 22 Mar 2006 17:11:58 +1100
User-Agent: KMail/1.8.3
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
References: <200603200234.01472.kernel@kolivas.org> <1142901862.441f4c66c748e@vds.kolivas.org> <200603211911.01829.rjw@sisk.pl>
In-Reply-To: <200603211911.01829.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221711.58390.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006 05:11 am, Rafael J. Wysocki wrote:
> On Tuesday 21 March 2006 01:44, kernel@kolivas.org wrote:
> > Are you looking at swap still in use? Swap prefetch keeps a copy of
> > prefetched pages on backing store as well as in ram so the swap space
> > will not be freed on prefetching.
>
> It looks like I have to debug it a bit more.  Unfortunately I've been
> having a lot of work to do recently, so it'll take some time.

No rush whatsoever! I'd just like to help on this.

> > I don't understand what you mean by it won't matter?
>
> Well, sorry.  Of course it will matter.  What I wanted to say is that in
> this case tbe built-in swsusp would be affected as well as the userland
> suspend, because the hook was in a function used by both.

Understood. So I'll modify it to hook into only built-in swsusp restore when I 
get a chance.

Cheers,
Con
