Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSIIOaI>; Mon, 9 Sep 2002 10:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSIIOaI>; Mon, 9 Sep 2002 10:30:08 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:36113
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S315337AbSIIOaH>; Mon, 9 Sep 2002 10:30:07 -0400
Subject: Re: [PATCH][RFC] per isr in_progress markers
From: Robert Love <rml@tech9.net>
To: zwane@mwaikambo.name
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020909094959.5A955BC51@hemi.commfireservices.com>
References: <20020909094959.5A955BC51@hemi.commfireservices.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 10:34:47 -0400
Message-Id: <1031582090.15799.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 05:49, zwane@mwaikambo.name wrote:

>    I sent you a bad patch yesterday.

I think Linus raises some important points wrt SMP performance.  At the
same time, I think your patch is very simple and has the possibility to
provide improved performance on SMP _and_ UP when dealing with busy
shared interrupt handlers.

For example, consider two handlers on the same line.  Even on UP, we can
find one slower handler blocking the run of another.  So I think the
benefit to latency is clear.

I dunno about throughput... Linus's points need to be addressed.

	Robert Love

