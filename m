Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTIMUxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbTIMUxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:53:09 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:65036
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262190AbTIMUxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:53:07 -0400
Subject: Re: [RFC] Enabling other oom schemes
From: Robert Love <rml@tech9.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: rusty@linux.co.intel.com, riel@conectiva.com.br, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030913174825.GB7404@mail.jlokier.co.uk>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
	 <20030913174825.GB7404@mail.jlokier.co.uk>
Content-Type: text/plain
Message-Id: <1063476152.24473.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sat, 13 Sep 2003 16:52:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-13 at 13:48, Jamie Lokier wrote:

> Also, when the OOM condition is triggered I'd like the system to
> reboot, but first try for a short while to unmount filesystems cleanly.
> 
> Any chance of those things?

I like all of these ideas.

One thing to keep in mind is that during a real OOM condition, we cannot
allocate _any_ memory.  None. Zilch.

And that makes some things very hard.  When we start getting into things
such as complicated policies that kill nonessential services first, et
cetera... there comes a time where a lot of communication is needed
(probably with user-space).  Hard to do that with no memory.

I do like all of this, however, and want to see some different OOM
killers.

	Robert Love


