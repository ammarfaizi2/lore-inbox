Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbSLTAVL>; Thu, 19 Dec 2002 19:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267659AbSLTAVL>; Thu, 19 Dec 2002 19:21:11 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15123
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267654AbSLTAVJ>; Thu, 19 Dec 2002 19:21:09 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200212201122.59691.conman@kolivas.net>
References: <200212200850.32886.conman@kolivas.net>
	 <3E025E1A.EA32918A@digeo.com> <1040343306.2519.85.camel@phantasy>
	 <200212201122.59691.conman@kolivas.net>
Content-Type: text/plain
Organization: 
Message-Id: <1040344153.2521.92.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 19:29:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 19:22, Con Kolivas wrote:

> Is it just because the base timeslices are longer than the old scheduler?

Could be.  The default timeslice was around 50ms in 2.4.  The default in
2.5 with a min of 10 and a max of 300 is about 100ms.

It could be that without the priority boost, 100ms is too long and
capable of starving tasks (which, without the priority boost, are all at
the same level and thus scheduled round-robin).

	Robert Love

