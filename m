Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUJOPrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUJOPrc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUJOPrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:47:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37534 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268043AbUJOPrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:47:25 -0400
Date: Fri, 15 Oct 2004 11:46:58 -0400
From: Dave Jones <davej@redhat.com>
To: Daniele Pizzoni <auouo@tin.it>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       pazke@orbita.don.sitek.net
Subject: Re: janitoring printk with no KERN_ constants, kill all defaults?
Message-ID: <20041015154658.GD23638@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Daniele Pizzoni <auouo@tin.it>, lkml <linux-kernel@vger.kernel.org>,
	kernel-janitors <kernel-janitors@lists.osdl.org>,
	pazke@orbita.don.sitek.net
References: <1097855099.3004.64.camel@pdp11.tsho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097855099.3004.64.camel@pdp11.tsho.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 05:44:59PM +0200, Daniele Pizzoni wrote:

 > I ask, what rationale there is behind checking all printks to include
 > the "appropriate" constant? Should then we make printk fail when called
 > without KERN_ constant? Or can I force with a sed script all defaulted
 > printk to KERN_WARNING?

No. Consider this..

	printk (KERN_INFO "blah blah ");
	if (foo)
		printk ("%s", stringptr);
	else
		printk ("%d", number);
	printk ("\n");

There's nothing wrong with any of those printk's, so you
cannot do the checks you mention above.

		Dave

