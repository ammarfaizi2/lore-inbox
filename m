Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVDEACh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVDEACh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDEABZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 20:01:25 -0400
Received: from ozlabs.org ([203.10.76.45]:38790 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261519AbVDEAAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 20:00:18 -0400
Subject: Re: [patch 2/3] hd eliminate bad section references
From: Rusty Russell <rusty@rustcorp.com.au>
To: maximilian attems <janitor@sternwelten.at>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20050404230543.GA14823@sputnik.stro.at>
References: <20050404181102.GB12394@sputnik.stro.at>
	 <4251BBC5.8000802@osdl.org>  <20050404230543.GA14823@sputnik.stro.at>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 10:00:16 +1000
Message-Id: <1112659216.18455.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 01:05 +0200, maximilian attems wrote:
> On Mon, 04 Apr 2005, Randy.Dunlap wrote:
> > Rusty, can you explain when __setup functions are called relative
> > to in-kernel init functions?  or put another way, can a __setup
> > function safely call in __init function?

Yes.  init sections are discarded just before "init" is exec'ed, ie. at
the last moment in the boot process.  __setup() functions are called at
the same time as module_param() parsing, which is all done before the
various initcall/module_init calls.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

