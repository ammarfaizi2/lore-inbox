Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTJGWFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 18:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbTJGWFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 18:05:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:63426 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262881AbTJGWFB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 18:05:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Larry Kessler <kessler@us.ibm.com>
To: Jim Keniston <jkenisto@us.ibm.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Net device error logging
Date: Tue, 7 Oct 2003 14:58:30 -0700
User-Agent: KMail/1.4.3
Cc: acme@conectiva.com.br, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, jkenisto <jkenisto@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <3F7C967F.A06A512E@us.ibm.com> <1065491087.2601.103.camel@localhost.localdomain> <3F8314A9.6FDD0274@us.ibm.com>
In-Reply-To: <3F8314A9.6FDD0274@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310071458.30548.kessler@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 October 2003 12:31, Jim Keniston wrote:
> 1. Is __netdev_printk's message-prefix format the right one?  If not,
> what should it be?

IMO, yes its the right format, since it identifies which device, and in a
consistent way similar to dev_printk().  What's more important than re-opening
this debate is making the current version available in the base so drivers can
start being modified to use it.  The message-prefix could change, if
experience indicates a benefit for consumers of printk messages.  

> 2. Should we support some sort of configurable prefix format?  E.g.,
> In my driver, I want the prefix to give the driver name, interface
> name, and source file and line number, so...
> 	netdev->msg_prefix = "%D:%I: %F:%L: ";
 
There are cases where a configurable prefix makes sense, but the goal here for
netdev_printk() was clearly stated from the beginning (id which device...no more, 
no less).  

> 3. Should netdev_* instead be used to enforce the "right" format?

Yes, for reasons already stated.
