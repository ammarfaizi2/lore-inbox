Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbUCZLJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 06:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbUCZLJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 06:09:37 -0500
Received: from ns.suse.de ([195.135.220.2]:23990 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264006AbUCZLJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:09:35 -0500
Date: Fri, 26 Mar 2004 08:10:18 +0100
From: Andi Kleen <ak@suse.de>
To: Robin Holt <holt@sgi.com>
Cc: Zoltan.Menyhart_AT_bull.net@nospam.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Migrate pages from a ccNUMA node to another
Message-Id: <20040326081018.0f34e281.ak@suse.de>
In-Reply-To: <20040326103959.GB14360@lnx-holt>
References: <4063F188.66DB690A@nospam.org>
	<20040326103959.GB14360@lnx-holt>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004 04:39:59 -0600
Robin Holt <holt@sgi.com> wrote:

> One thing that would probably help considerably, in addition to the
> syscall you seem to be proposing, would be an addition to the
> task_struct.  The new field would specify which node to attempt
> allocations on.  Before doing a fork, the parent would do a
> syscall to set this field to the node the child will target.  It
> would then call fork.  The PGDs et al and associated memory, including
> the task struct and pages would end up being allocated based upon
> that numa node's allocation preference.

You just described the process policy of NUMA API.

-Andi
