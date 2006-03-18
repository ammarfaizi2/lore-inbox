Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWCRUQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWCRUQG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWCRUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:16:06 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:40414
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750918AbWCRUQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:16:04 -0500
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
In-Reply-To: <20060318120728.63cbad54.akpm@osdl.org>
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142830.607556000@localhost.localdomain>
	 <20060318120728.63cbad54.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 21:16:15 +0100
Message-Id: <1142712975.17279.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 12:07 -0800, Andrew Morton wrote:

> From my reading, 2.4's sys_setitimer() will normalise the incoming timeval
> rather than rejecting it.  And I think 2.6.13 did that too.
> 
> It would be bad of us to change this behaviour, even if that's what the
> spec says we should do - because we can break existing applications.
> 
> So I think we're stuck with it - we should normalise and then accept such
> timevals.  And we should have a big comment explaining how we differ from
> the spec, and why.

Hmm. How do you treat a negative value ?

	tglx


