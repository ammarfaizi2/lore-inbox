Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWFKSy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWFKSy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 14:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWFKSy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 14:54:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26302
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750764AbWFKSyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 14:54:25 -0400
Date: Sun, 11 Jun 2006 11:54:30 -0700 (PDT)
Message-Id: <20060611.115430.112290058.davem@davemloft.net>
To: rlrevell@joe-job.com
Cc: folkert@vanheusden.com, matti.aarnio@zmailer.org,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1150048497.14253.140.camel@mindpipe>
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
	<20060611160243.GH20700@vanheusden.com>
	<1150048497.14253.140.camel@mindpipe>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Revell <rlrevell@joe-job.com>
Date: Sun, 11 Jun 2006 13:54:57 -0400

> On Sun, 2006-06-11 at 18:02 +0200, Folkert van Heusden wrote:
> > Hmmm.
> > What about using spamhaus.org sbl+xbl list?
> > I used to receive 1200 spam messages a day, with spamhaus only half of
> > that.
> 
> What about doing nothing?  The percentage of spam on LKML is vanishingly
> small.

We definitely need a better spam solution at vger, the reason is that
the current mechanism (ad-hoc by-hand regexp blocking) creates lots of
problems.  For one thing, it means that people with names in languages
other than english get blocked when their emails are quoted in
postings.  This is because we don't understand a lot of languages, so
we just regexp block multibyte characters typically assosciated with
that language in order to block spam written in that language.

That isn't acceptable in the long term.

To be honest I'm all for some kind of bayesian filter at vger as long
as the rejected postings go somewhere into a folder I can scan every
couple of days looking for false positives.
