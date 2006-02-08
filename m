Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWBHIHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWBHIHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWBHIHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:07:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:40679 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161069AbWBHIG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:06:59 -0500
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add execute_in_process_context() API
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Feb 2006 09:06:51 +0100
In-Reply-To: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel>
Message-ID: <p737j86l1es.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

In general this seems like a lot of code for a simple problem.
It might be simpler to just put the work structure into the parent
object and do the workqueue unconditionally


> +	if (unlikely(!wqw)) {
> +		printk(KERN_ERR "Failed to allocate memory\n");
> +		WARN_ON(1);

WARN_ON for GFP_ATOMIC failure is bad. It is not really a bug.

-Andi
