Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271005AbUJVJec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271005AbUJVJec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270908AbUJVJak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:30:40 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:60551 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S270916AbUJVJ0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:26:49 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
Date: Fri, 22 Oct 2004 10:26:22 +0100
User-Agent: KMail/1.7
Cc: Sergei Haller <Sergei.Haller@math.uni-giessen.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <ak@muc.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
In-Reply-To: <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410221026.22531.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 Oct 2004 09:59, Sergei Haller wrote:
>
> If I disable NUMA in 2.6.8.1, it works stable!
>
> The same with 2.6.9, which is out for a few days: if NUMA is disabled,
> everything's find, if NUMA is enabled, the kernel crashes (as described in
> previous mails)
>
> What is this NUMA by the way? Is it OK to live without?
>

Non uniform memory architecture. Basically, some of the ram is attached to 
cpu1 and some to cpu2. They can still access each others ram using 
HyperTransport, but can access their own ram faster. I'm no expert, but I 
guess that the NUMA code tries to achieve persistent process cpu affinity and 
keep all process memory in the relevant cpu's NUMA ram bank. Or something :)

Your board isn't numa, in the sense that all the ram is attached to one cpu, 
but I don't think that it should break when NUMA is enabled.

I've cc'ed Andi Kleen (x86_64 supremo) who might have some insights, but I'm 
guessing he'll say "Bios problem - tough luck". I might be wrong ;)

Andrew Walrond
