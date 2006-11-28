Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756869AbWK1Vip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869AbWK1Vip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756871AbWK1Vip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:38:45 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756869AbWK1Vip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:38:45 -0500
Date: Tue, 28 Nov 2006 13:37:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Don Mullis <dwm@meer.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 1/2 -mm] fault-injection: safer defaults, trivial
 optimization, cleanup
Message-Id: <20061128133754.bad99ddb.akpm@osdl.org>
In-Reply-To: <1164699866.2894.88.camel@localhost.localdomain>
References: <1164699866.2894.88.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 23:44:26 -0800
Don Mullis <dwm@meer.net> wrote:

> Set /debug/fail*/* defaults supposed most likely to please a new user.
> Clamp /debug/fail*/stacktrace-depth to MAX_STACK_TRACE_DEPTH.
> 
> In should_fail(), move stack-unwinding test past cheaper tests (performance
> gain not quantified).  Simplify logic; eliminate goto.
> Use bool/true/false consistently.
> 
> Correct and disambiguate documentation.

We'd prefer one-patch-per-concept, please. This all sounds like about
six patches.

We _could_ merge this patch as-is, but it means that when this stuff
finally hits mainline it would go in as a nice sequence of logical patches,
followed by a random thing which is splattered all over all the preceding
patches.
