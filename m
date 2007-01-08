Return-Path: <linux-kernel-owner+w=401wt.eu-S1161212AbXAHXNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbXAHXNJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbXAHXNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:13:09 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:53563 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161212AbXAHXNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:13:08 -0500
Date: Mon, 8 Jan 2007 15:13:07 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All Transmeta CPUs have constant TSCs
In-Reply-To: <45A2AEE0.4090707@zytor.com>
Message-ID: <Pine.LNX.4.64.0701081506330.12282@twinlark.arctic.org>
References: <200701050148.l051mHGM005275@terminus.zytor.com>
 <Pine.LNX.4.61.0701051524440.7813@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0701072358010.26307@twinlark.arctic.org>
 <Pine.LNX.4.61.0701082118370.23737@yvahk01.tjqt.qr> <45A2AEE0.4090707@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007, H. Peter Anvin wrote:

> I *definitely* support the concept that RDPMC 0 should could CPU cycles by
> convention in Linux.

unfortunately that'd be very limiting and annoying on core2 processors 
which have dedicated perf counters for clocks unhalted (actual vs. 
nominal), but only 2 configurable perf counters.  i forget what ecx value 
gets you the dedicated counters... but a solution which might work would 
be a syscall to return the perf counter number...

or we could just merge perfmon ;)

-dean
