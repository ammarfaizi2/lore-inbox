Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUKOBRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUKOBRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUKOBQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:16:54 -0500
Received: from ozlabs.org ([203.10.76.45]:57009 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261425AbUKOBOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:14:51 -0500
Subject: Re: [PATCH] handle quoted module parameters
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: yiding_wang@agilent.com, arjan@infradead.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41943931.4090008@osdl.org>
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AED@wcosmb07.cos.agilent.com>
	 <41943754.6090806@osdl.org>  <41943931.4090008@osdl.org>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 12:14:47 +1100
Message-Id: <1100481287.7381.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 20:16 -0800, Randy.Dunlap wrote: 
> Here's a patch with better description.
> 
> 
> Fix module parameter quote handling.
> Module parameter strings (with spaces) are quoted like so:
> "modprm=this test"
> and not like this:
> modprm="this test"

Well, the quote handling in insmod was ripped out after 3.0, exactly
because it was broken like this.  But modprobe will use the latter form,
since it will paste it straight from the modprobe.conf file (which needs
quotes in options lines).

Hope that clarifies,
Rusty.
PS. module-init-tools 3.1 just out...
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

