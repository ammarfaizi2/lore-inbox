Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVHDBbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVHDBbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVHDBbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:31:05 -0400
Received: from ozlabs.org ([203.10.76.45]:10713 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261727AbVHDBbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:31:04 -0400
Subject: Re: [PATCH] flush icache early when loading module
From: Rusty Russell <rusty@rustcorp.com.au>
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508040234.49661.thomas@koeller.dyndns.org>
References: <200508040234.49661.thomas@koeller.dyndns.org>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 11:30:59 +1000
Message-Id: <1123119059.16494.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 02:34 +0200, Thomas Koeller wrote:
> The patch below, created against linux-2.6.12.3, changes the sequence of
> operations performed during module loading to flush the instruction cache
> before module parameters are processed. If a module has parameters of an
> unusual type that cannot be handled using the standard accessor functions
> param_set_xxx and param_get_xxx, it has to to provide a set of accessor
> functions for this type. This requires module code to be executed during
> parameter processing, which is of course only possible after the icache
> has been flushed.
> 
> Signed-off-by: Thomas Koeller <thomas@koeller.dyndns.org>

Yes, well caught.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

