Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268654AbUIAF2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268654AbUIAF2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268657AbUIAF2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:28:37 -0400
Received: from ozlabs.org ([203.10.76.45]:40416 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268654AbUIAF21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:28:27 -0400
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
In-Reply-To: <4134DEF4.8090001@grupopie.com>
References: <4134DEF4.8090001@grupopie.com>
Content-Type: text/plain
Message-Id: <1094016277.17828.53.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 15:24:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 06:26, Paulo Marques wrote:
> This patch implements the "is_exported" bit in the kallsyms_names
> compressed stream, so that a "cat /proc/kallsyms" doesn't call
> is_exported on every iteration.

Prefer the patch split into "comments", "inconsistent kallsyms data fix"
and "speedup".  I also prefer using a whole letter over a single bit:
this allows archs which have wierd nm letters to express them, and
instead of case indicating what symbols are exported, we get the real
correct results.

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

