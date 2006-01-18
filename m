Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbWARVqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWARVqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWARVqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:46:14 -0500
Received: from kanga.kvack.org ([66.96.29.28]:3802 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030477AbWARVqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:46:12 -0500
Date: Wed, 18 Jan 2006 16:42:04 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
Message-ID: <20060118214204.GG16285@kvack.org>
References: <20060118181955.GF16285@kvack.org> <Pine.LNX.4.44L0.0601181517060.4974-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601181517060.4974-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 03:23:20PM -0500, Alan Stern wrote:
> You can't use RCU protection around code that may sleep.  Whether the code
> remains loaded in the kernel or is part of a removable module doesn't
> enter into it.

A notifier callee should not be sleeping, if anything it should be putting 
its work onto a workqueue and completing it when it gets scheduled if it 
has to do something that blocks.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
