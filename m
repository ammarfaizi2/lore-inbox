Return-Path: <linux-kernel-owner+w=401wt.eu-S932643AbXAHJJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbXAHJJc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbXAHJJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:09:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37408 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643AbXAHJJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:09:31 -0500
Date: Mon, 8 Jan 2007 09:09:26 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Message-ID: <20070108090926.GF17561@ftp.linux.org.uk>
References: <1168244100.9034.2.camel@dsl081-166-245.sea1.dsl.speakeasy.net> <20070108084707.48375.qmail@web55605.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108084707.48375.qmail@web55605.mail.re4.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 12:47:07AM -0800, Amit Choudhary wrote:
 
> Let's try to apply the same logic to my explanation:
> 
> KFREE() macro has __actually__ been used at atleast 1000 places in the kernel by atleast 50
> different people. Doesn't that lend enough credibility to what I am saying.

No.  Simple "it happens a lot of times" is _not_ enough to establish
credibility of "it should be done that way".  It is a good reason to
research the rationale in each case.
 
> People did something like this 1000 times: kfree(x), x = NULL. I simply proposed the KFREE() macro
> that does the same thing. Resistance to something that is already being done in the kernel. I
> really do not care whether it goes in the kernel or not. There are lots of other places where I
> can contribute. But I do not understand the resistance.
> 
> It is already being done in the kernel.

And each instance either has a reason for doing it that way or is useless
or is a bug.  Reasons, where they actually exist, very likely are not
uniform.

Blind copying of patterns without understanding what and why they are
doing is a Very Bad Thing(tm).  That's how the bugs are created and
propagated, BTW.
