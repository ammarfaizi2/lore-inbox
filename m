Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWJUCmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWJUCmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 22:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWJUCmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 22:42:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8686 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030383AbWJUCmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 22:42:14 -0400
Date: Fri, 20 Oct 2006 22:41:05 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more helpful WARN_ON and BUG_ON messages
Message-ID: <20061021024105.GA17706@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Eric Sandeen <sandeen@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4538F81A.2070007@redhat.com> <20061020214101.GX3502@stusta.de> <45394615.5050406@redhat.com> <20061020220717.GY3502@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020220717.GY3502@stusta.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 12:07:17AM +0200, Adrian Bunk wrote:

 > > Most debugging code makes the kernel bigger, slower... and easier to
 > > debug, no?
 > > 
 > > It's not a question of not being -able- to locate sources; it's a
 > > question of being able to look at a bug report and triage it quickly
 > > without digging around to find the kernel du jour that produced it.  *shrug*
 > 
 > It's not that BUGs were that frequent.

You're not trying hard enough ;) 

 > And with your suggestion "I suppose this could be put under CONFIG_DEBUG", 
 > it would anyway be turned off by nearly everyone.

For better bug reports, 16K is peanuts. We had exactly the same straw-man
come up when kksymoops was first proposed. And now, most people don't run
without it.

I've seen numerous cases where reporters have hand transcribed BUG() reports,
and got the line numbers wrong because they misremembered a 4 digit number.
Words are inherently easier to remember, and even if typoed, usually there's
enough context to figure out what the problem was without another round-trip
to the bug reporter.

If this were optional, I don't see how anyone can argue against it,
and that should be a trivial improvement to Eric's existing patch.

	Dave

-- 
http://www.codemonkey.org.uk
