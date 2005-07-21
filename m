Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVGUUGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVGUUGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 16:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVGUUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 16:06:42 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:58760 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261866AbVGUUFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 16:05:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
Date: Thu, 21 Jul 2005 22:05:26 +0200
User-Agent: KMail/1.8.1
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, Pavel Machek <pavel@ucw.cz>,
       Andreas Steinmetz <ast@domdv.de>, Dave Jones <davej@codemonkey.org.uk>
References: <42DD67D9.60201@stud.feec.vutbr.cz> <20050721152053.GA21475@atrey.karlin.mff.cuni.cz> <42DFBE3F.20602@stud.feec.vutbr.cz>
In-Reply-To: <42DFBE3F.20602@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507212205.26701.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 of July 2005 17:24, Michal Schmidt wrote:
> Pavel Machek wrote:
> >>I'm trying to do something similar for x86_64. See the attached patch.
> >>Unfortunately, it doesn't help. The behaviour seems unchanged (resume 
> >>still works iff amd64-agp wasn't loaded before suspend).
> > 
> > 
> > Are you sure problem is on level4_pgt? We probably use constant
> > level4_pgt but split pages at some deeper level. You may want try
> > saving 3rd-level table, instead.
> 
> I'm not sure about that at all. That was just my attempt of cargocult 
> programming :-)
> OK, I'll try saving the 3rd-level table. It'll take me some time to 
> figure out how to do that, however :-)

I think the amd64-agp is the problem here.  There are some memory mappings
that seem to require the hardware to be initialized before they can be used
safely (at least as far as I understand it).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
