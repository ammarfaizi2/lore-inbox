Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbTILVwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTILVwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:52:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48398
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261594AbTILVwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:52:02 -0400
Date: Fri, 12 Sep 2003 14:52:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: John Bradford <john@grabjohn.com>
Cc: anthony.truong@mascorp.com, linux-kernel@vger.kernel.org,
       jamie@shareable.org, willy@debian.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030912215203.GF30584@matchmail.com>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	anthony.truong@mascorp.com, linux-kernel@vger.kernel.org,
	jamie@shareable.org, willy@debian.org
References: <200309121641.h8CGflK0000145@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309121641.h8CGflK0000145@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 05:41:47PM +0100, John Bradford wrote:
> #ifdef CONFIG_MMIO
> 	writel(... );
>         readl(... );
> #endif
> #ifdef CONFIG_NO_MMIO
> 	outl(... );
> 	inl(...);
> #endif
> #ifdef CONFIG_DONT_CARE_MMIO
> 	if (dev->mmio) {	
> 		writel(... );
> 		readl(... );
> 	} else {
> 		outl(... );
> 		inl(... );
> 	}
> #endif

If there's already a config option that keeps code from being compiled when
it's not used, then it should stay.

I'm all for a bunch of config options hidden away in broader questions in
the config system...
