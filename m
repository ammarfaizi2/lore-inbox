Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUIISZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUIISZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUIISYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:24:16 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:62362 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266646AbUIISFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:05:48 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
Date: Thu, 9 Sep 2004 20:02:19 +0200
User-Agent: KMail/1.6.1
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20040908172503.384144933@zion.localdomain> <20040908111204.I1973@build.pdx.osdl.net>
In-Reply-To: <20040908111204.I1973@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409092002.19134.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 20:12, Chris Wright wrote:
> * blaisorblade_spam@yahoo.it (blaisorblade_spam@yahoo.it) wrote:
> > Trivial: don't lock the queue spinlock when called from the request
> > function. Since the faulty function must use spinlock in another case,
> > double-case it. And since we will never use both functions together, let
> > no object code be shared between them.
>
> Why not add a helper which locks around the core function.  Then either
> call helper or core function directly depending on locking needs?
I'm happy with whatever is nicer.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
