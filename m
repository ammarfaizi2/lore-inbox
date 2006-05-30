Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWE3TPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWE3TPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWE3TPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:15:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbWE3TPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:15:23 -0400
Date: Tue, 30 May 2006 12:19:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/6] statistics infrastructure
Message-Id: <20060530121920.8c8f5d34.akpm@osdl.org>
In-Reply-To: <447C7E1F.7020602@de.ibm.com>
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20060524155735.04ed777a.akpm@osdl.org>
	<447C7E1F.7020602@de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 19:17:19 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> Would I get away with making printk_clock() a timestamp_clock() that
> should be used by anyone exporting nsec_to_timestamp()-formated time
> stamps to user space, including me?
> 
> I would then continue to see the use of sched_clock() in printk_clock()
> ... aehm timestamp_clock() as somebody else's problem (or at least
> as a subordinate problem).

Sure, a generic kernel-wide nsec-resolution timestamp_clock() makes sense
to me.

The default implementation can use sched_clock() but arch maintainers
can/should override it (vai attribute-weak) and do somethnig better.

