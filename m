Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbUDBJTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 04:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUDBJTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 04:19:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22915 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263372AbUDBJTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 04:19:37 -0500
Date: Fri, 2 Apr 2004 04:19:11 -0500
From: Alan Cox <alan@redhat.com>
To: Ken Ashcraft <kash@stanford.edu>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, mc@cs.stanford.edu
Subject: Re: [CHECKER] Race condition in i2o_core.c
Message-ID: <20040402091911.GB22652@devserv.devel.redhat.com>
References: <5.2.1.1.2.20040401172809.01bcfa50@kash.pobox.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20040401172809.01bcfa50@kash.pobox.stanford.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 05:46:00PM -0800, Ken Ashcraft wrote:
> Looks like there is a race condition in i2o_core_reply involving the 
> variable "evt_in".  Notice that the increment of evt_in is protected by the 
> lock, but the reads are not protected.  It looks like "events" should also 
> be protected by the lock.  If this is not a race condition, the increment 
> should not be inside the critical section.
> 
> Feedback is appreciated.

Looks a fair catch to me.
