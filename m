Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUJOQRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUJOQRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJOQRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:17:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:9167 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268122AbUJOQRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:17:44 -0400
Date: Fri, 15 Oct 2004 09:17:55 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Daniele Pizzoni <auouo@tin.it>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       pazke@orbita.don.sitek.net
Subject: Re: [KJ] janitoring printk with no KERN_ constants, kill all defaults?
Message-ID: <20041015161755.GB2134@us.ibm.com>
References: <1097855099.3004.64.camel@pdp11.tsho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097855099.3004.64.camel@pdp11.tsho.org>
X-Operating-System: Linux 2.6.9-rc4 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 05:44:59PM +0200, Daniele Pizzoni wrote:
> I'm investigating this (from the kernel janitors TODO list):

<snip>

> I ask, what rationale there is behind checking all printks to include
> the "appropriate" constant? Should then we make printk fail when called
> without KERN_ constant? Or can I force with a sed script all defaulted
> printk to KERN_WARNING?

I think the rationale is to compare the comments from linux/kernel.h for
the KERN_* definitions to their usage in the code and make sure they
correspond accordingly, e.g. KERN_EMERG is only used if the system is
actually unusable.

Hope that helps,
Nish
