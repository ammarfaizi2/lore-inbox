Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWHMURy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWHMURy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 16:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHMURy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 16:17:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:28577 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751406AbWHMURx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 16:17:53 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH for review] [123/145] i386: make fault notifier unconditional and export it
Date: Sun, 13 Aug 2006 22:17:48 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060810935.775038000@suse.de> <20060810193722.8082B13B8E@wotan.suse.de> <20060813152859.GB3543@stusta.de>
In-Reply-To: <20060813152859.GB3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608132217.48966.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 17:28, Adrian Bunk wrote:
> > It's needed for external debuggers and overhead is very small.
> >...
> 
> We are currently trying to remove exports not used by any in-kernel 
> code.

That ``we'' doesn't include me at least.

> 
> The patch description also lacks the name of what you call "external 
> debuggers" (I assume the exports are not for a theoretical usage but for 
> an already existing debugger?).

The fault chain is needed for pretty much any debugger, including
kgdb, kdb, nlkd. The one in this case was NLKD.
 
> Especially nowadays where people demand deprecation periods for removing 
> exports without any in-kernel users there must be a _very_ good 
> justification when adding such exports.

I've always exported symbols when people can make a reasonable case that they 
need it for extern free non broken by design code.

On the other hand I have no problems with removing unused exports
that don't have such a case or are clearly not a useful external
interface.

> BTW1: The subject of this email is wrong (it's the x86_64 patch).

Fixed, thanks

-Andi
