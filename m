Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270761AbTGUVWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270757AbTGUVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:22:35 -0400
Received: from dp.samba.org ([66.70.73.150]:16546 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270756AbTGUVUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:20:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: torvalds@transmeta.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] percpu struct members. 
In-reply-to: Your message of "Mon, 21 Jul 2003 19:56:19 +0100."
             <20030721185619.GB6912@mail.jlokier.co.uk> 
Date: Tue, 22 Jul 2003 07:27:41 +1000
Message-Id: <20030721213554.723822C0FD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030721185619.GB6912@mail.jlokier.co.uk> you write:
> Rusty Russell wrote:
> > The current percpu macros do not allow __get_cpu_var(foo.val1)
> > which makes building macros on top of them really difficult.
> 
> What's the problem with __get_cpu_var(foo).val1 ?

Nothing: that will still work, too.  But not say you have a macro (as
we do in local_t):

	local_cpu_inc(cpuvar)

if cpuvar is a struct, you want this to work:

	local_cpu_inc(cpuvar.member)

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
