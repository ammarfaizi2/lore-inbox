Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbULTMHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbULTMHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbULTMHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:07:53 -0500
Received: from mail.aei.ca ([206.123.6.14]:33791 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261256AbULTMHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:07:49 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Mon, 20 Dec 2004 07:06:05 -0500
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, lista4@comhem.se,
       linux-kernel@vger.kernel.org, mr@ramendik.ru, kernel@kolivas.org,
       riel@redhat.com
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1> <20041219231250.457deb12.akpm@osdl.org> <41C682F1.20200@yahoo.com.au>
In-Reply-To: <41C682F1.20200@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412200706.06534.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 December 2004 02:44, Nick Piggin wrote:
> Andrew Morton wrote:
> > Voluspa <lista4@comhem.se> wrote:
> > 
> >>Would be nice though if someone else could verify...
> > 
> > 
> > Well I'd love to, but afaik the only workloads which we currently know of
> > involve complex userspace apps which I have no experience running.
> > 
> > Did anyone come up with a simple step-by-step procedure for reproducing the
> > problem?  It would be good if someone could do this, because I don't think
> > we understand the root cause yet?
> > 
> 
> I admit to generally being in the same boat as you with respect to
> running complex userspace apps.
> 
> However, based on this and other scattered reports, I'd say it seems
> quite likely that token based thrashing control is the culprit. Based
> on the cost/benefit, I wonder if we should disable TBTC by default for
> 2.6.10, rather than trying to fix it, and try again for 2.6.11?
> 
> Rik? Andrew?
> 
> Also, it would be nice to have a sysctl to *completely* disable TBTC,
> that would make testing easier.

Except that disabling it (with 0) reportedly did not solve the problem.  There is 
a possibility that its a more complex issue...

Ed Tomlinson
