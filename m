Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbULEEHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbULEEHs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 23:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbULEEHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 23:07:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:16333 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261247AbULEEHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 23:07:33 -0500
Subject: Re: Linux 2.6.10-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200412041903.55583.david-b@pacbell.net>
References: <200412041903.55583.david-b@pacbell.net>
Content-Type: text/plain
Date: Sun, 05 Dec 2004 15:07:16 +1100
Message-Id: <1102219637.18809.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why was that changed?  Are you sure it's not just a bug higher up
> in the call stack?  Classically(*), both suspend() and resume()
> methods are called in contexts that can sleep, so that's a big
> change I'd expect to impact other drivers too.  In fact that'd
> explain a lot of other messages I saw reported on the list...

Yes, lots of drivers are expected to be able to schedule in suspend and
resume requests. If that was broken upstream, then this is a big BUG.

> - Dave
> 
> (*) Since APM days if not before.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

