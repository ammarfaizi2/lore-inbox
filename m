Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWHTQqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWHTQqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWHTQqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:46:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11428 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750936AbWHTQqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:46:10 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Arjan van de Ven <arjan@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44E88DC3.7000708@redhat.com>
References: <20060820003840.GA17249@openwall.com>
	 <20060820100706.GB6003@steel.home>  <20060820153037.GA20007@openwall.com>
	 <1156089203.23756.46.camel@laptopd505.fenrus.org>
	 <44E88DC3.7000708@redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 20 Aug 2006 18:45:15 +0200
Message-Id: <1156092315.23756.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 09:28 -0700, Ulrich Drepper wrote:
> Arjan van de Ven wrote:
> > sounds like a good argument to get the setuid functions marked
> > __must_check in glibc...
> 
> There are too many false positives.  E.g., in a SUID binaries switching
> back from a non-root UID to root will not fail.

that is not entirely clear; there is apparently a memory allocation in
this codepath which can fail (the patch in this thread is patching
that).....

>   Very common.
> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

