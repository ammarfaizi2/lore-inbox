Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTDMDyy (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTDMDyx (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:54:53 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:9487
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263163AbTDMDyx 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 23:54:53 -0400
Subject: Re: Quick question about hyper-threading
From: Robert Love <rml@tech9.net>
To: Timothy Miller <tmiller10@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000701c3016a$b9d76c90$6801a8c0@epimetheus>
References: <000701c3016a$b9d76c90$6801a8c0@epimetheus>
Content-Type: text/plain
Organization: 
Message-Id: <1050206802.2291.515.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 Apr 2003 00:06:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 23:13, Timothy Miller wrote:
> On a hyper-threaded CPU, it seems to me that there could be a lot of
> cache-thrashing if the two processes running are completely unrelated.  On
> the other hand, if one process has two threads, then they would benefit (or
> hurt less) from the cache-sharing, because they share the same memory space.
> Does the HT-aware scheduler attempt to take this into account by scheduling
> two related threads to run simultaneously on the same CPU as often as
> possible (unless you're in a multi-processor system and another CPU would
> otherwise be idle)?


No, the current scheduler (HT or stock 2.5) does not do this.

Your theories are correct.  It would be interesting to try this and see.

It is nontrivial to do the ->mm checks in the scheduler though -
certainly they cannot be done easily (if at all) in constant-time (i.e.,
it won't be O(1)).

	Robert Love

