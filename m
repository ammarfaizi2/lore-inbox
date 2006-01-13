Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422926AbWAMUYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWAMUYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422927AbWAMUYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:24:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422926AbWAMUYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:24:14 -0500
Date: Fri, 13 Jan 2006 12:23:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: ak@suse.de, hugh@veritas.com, bcasavan@americas.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Add tmpfs options for memory placement policies (Resend
 with corrected addresses).
Message-Id: <20060113122349.5c367e05.akpm@osdl.org>
In-Reply-To: <20060113162119.GF19156@lnx-holt.americas.sgi.com>
References: <20060113160406.GE19156@lnx-holt.americas.sgi.com>
	<20060113162119.GF19156@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> This patch introduces a tmpfs mount option which allows specifying a
>  memory policy and a second option to specify the nodelist for that policy.
>  With the default policy, tmpfs will behave as it does today.  This patch
>  adds support for preferred, bind, and interleave policies.
> 
>  The default policy will cause pages to be added to tmpfs files on the
>  node which is doing the writing.  Some jobs expect a single process to
>  create and manage the tmpfs files.  This results in a node which has a
>  significantly reduced number of free pages.
> 
>  With this patch, the administrator can specify the policy and nodes for
>  that policy where they would prefer allocations.

Confused.  Is this for applications which cannot be taught to use the
mempolicy API?
