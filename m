Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262926AbTDAXF6>; Tue, 1 Apr 2003 18:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262927AbTDAXF6>; Tue, 1 Apr 2003 18:05:58 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:58896
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262926AbTDAXF5>; Tue, 1 Apr 2003 18:05:57 -0500
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Wayne Whitney <whitney@math.berkeley.edu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304011512190.13867-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0304011512190.13867-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049239041.754.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 01 Apr 2003 18:17:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 18:13, Linus Torvalds wrote:

> Ok, I was too lazy to check. Anyway, the test-patch is worth trying, since
> one of the areas fixed had no pre-emption protection regardless (ie it
> used just a plain "smp_processor_id()"), and the patch should be
> technically equivalent (just uglier) to a proper get_cpu().

Yah, I just looked, and I noticed that too.

Whether or not this fixes it for Wayne, I think the right thing to do is
replace the first smp_processor_id() with get_cpu(), too.

	Robert Love

