Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267723AbUHPQEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267723AbUHPQEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267707AbUHPQDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:03:15 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:41572 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267775AbUHPP6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:58:17 -0400
Subject: Re: [PATCH] 2.6.8 synclink_cs.c replace syncppp with genhdlc
From: Paul Fulghum <paulkf@microgate.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040816162158.A11863@infradead.org>
References: <1092669058.2012.11.camel@deimos.microgate.com>
	 <20040816162158.A11863@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1092671882.2012.16.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Aug 2004 10:58:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 10:21, Christoph Hellwig wrote:
> > +#ifdef CONFIG_HDLC_MODULE
> > +#define CONFIG_HDLC 1
> >  #endif
> 
> shouldn't the drivers depend on hdlc instead?

They do.

When hdlc is enabled as a module:
CONFIG_HDLC_MODULE is defined
CONFIG_HDLC is not defined

When hdlc is enabled in kernel:
CONFIG_HDLC_MODULE is not defined
CONFIG_HDLC is defined

The HDLC interface in the synclink modules need
to be enabled for either case.
All the conditional compilation is done
on CONFIG_HDLC, and the above fragment
defines CONFIG_HDLC when HDLC is built as a
module.

Is there a better way of handling this?
 
--
Paul Fulghum
paulkf@microgate.com


