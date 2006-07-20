Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWGTNCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWGTNCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 09:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWGTNCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 09:02:41 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:36065 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S964822AbWGTNCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 09:02:40 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH][kernel-doc] Add DocBook documentation for workqueue functions
Date: Thu, 20 Jul 2006 15:03:54 +0200
User-Agent: KMail/1.9.3
Cc: Martin Waitz <tali@admingilde.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200607201145.19147.eike-kernel@sf-tec.de> <Pine.LNX.4.58.0607200548210.30200@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0607200548210.30200@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607201503.55036.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Thu, 20 Jul 2006, Rolf Eike Beer wrote:
> > kernel/workqueue.c was omitted from generating kernel documentation. This
> > adds a new section "Workqueues and Kevents" and adds documentation for
> > some of the functions.
> >
> > Some functions in this file already had DocBook-style comments, now they
> > finally become visible
>
> Cool, thanks much.
>
> Did you test it?

At least two of them.

> There should not be an empty ("*" only) line 
> between the function name + short description and the function
> parameter line(s).  If you generate output for these functions,
> the Description section will be there 2 times (i.e., repeated),
> so please just delete those lines and it will be Good.

Yes, I saw that. That's a very common problem all over the kernel. Now I see 
that the nano-howto says it's this way, but I've seen the other way for 
years. One example is vmalloc_32_user that I touched on monday.

I'll submit a version 3 of this soon. In the meantime "make mandocs" should 
either warn of those or handle them the right way (aka ignore the newline). 
If it would also warn on duplicate descriptions, at least in the same file, 
this would have catched my copy&waste bug in the first version also.

Eike
