Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWFFXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWFFXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWFFXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:42:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751363AbWFFXm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:42:56 -0400
Date: Tue, 6 Jun 2006 16:42:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060606164241.69d55238.akpm@osdl.org>
In-Reply-To: <4484D174.7080902@google.com>
References: <4484D174.7080902@google.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 17:51:00 -0700
Martin Bligh <mbligh@google.com> wrote:

> http://test.kernel.org/abat/34264/debug/console.log

What sort of machine is this, anyway?

> WARNING: Not an IBM x440/NUMAQ and CONFIG_NUMA enabled!

And is it expected that ZONE_NORMAL only has 384MB?  That seems awfully low
for a 64GB x86 machine.  Could be that we went oom because we chose to
allocate really big hash tables, based on the total amount of memory?

