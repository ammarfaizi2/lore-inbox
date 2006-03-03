Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWCCFqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWCCFqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 00:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWCCFqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 00:46:00 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2709
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932074AbWCCFp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 00:45:59 -0500
Date: Thu, 02 Mar 2006 21:45:56 -0800 (PST)
Message-Id: <20060302.214556.77789100.davem@davemloft.net>
To: anemo@mba.ocn.ne.jp
Cc: akpm@osdl.org, clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, johnstul@us.ibm.com, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date: Fri, 03 Mar 2006 13:31:25 +0900 (JST)

> I and Ralf talked a bit about the jiffies issue.  Making an union
> containing jiffies and jiffies_64 looks good to avoid such an
> optimization problem, but it would affect so many existing codes.

Maybe use an anonymous union?  That might help...
