Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSHVRSS>; Thu, 22 Aug 2002 13:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSHVRSR>; Thu, 22 Aug 2002 13:18:17 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:25875
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S314459AbSHVRSR>; Thu, 22 Aug 2002 13:18:17 -0400
Subject: Re: 2.4 kernel series and the oom_killer and
	/proc/sys/vm/overcommit_memory
From: Robert Love <rml@tech9.net>
To: Marc-Christian Petersen <m.c.p@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208221719.50568.m.c.p@gmx.net>
References: <200208221719.50568.m.c.p@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Aug 2002 13:22:27 -0400
Message-Id: <1030036948.857.3186.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 11:19, Marc-Christian Petersen wrote:

> My question now: Why isn't it possible, if overcommit_memory is 0, to really 
> check if there is enough memory or not, and if NOT just to display a message 
> like "Not enough memory for execution. Aborted" ?

Because the overcommit checks in 2.4 stock are heuristic in nature -
they simple compare an estimate of committed memory against what you are
trying to allocate.

In 2.5 and 2.4-ac we have strict overcommit which couple accurate
accounting of the committed address space with stricter rules to prevent
overcommit.

	Robert Love

