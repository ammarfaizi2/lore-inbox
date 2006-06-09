Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWFIXPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWFIXPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWFIXPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:15:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932584AbWFIXPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:15:51 -0400
Date: Fri, 9 Jun 2006 16:15:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, npiggin@suse.de,
       ak@suse.de, hugh@veritas.com
Subject: Re: Light weight counter 1/1 Framework
Message-Id: <20060609161531.249de5e1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091537350.3036@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606091216320.1174@schroedinger.engr.sgi.com>
	<20060609143333.39b29109.akpm@osdl.org>
	<Pine.LNX.4.64.0606091537350.3036@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> Eventcounter fixups

And the kernel still doesn't actually compile with this patch applied.  You
need to also apply light-weight-counters-counter-conversion.patch to make
page_alloc.c compile.  So either we break git-bisect or I fold two
inappropriate patches together or I need to patchwrangle it somehow.

<checks>

Yes, I need to fold them all together.

And fix the unused-variable warnings.

