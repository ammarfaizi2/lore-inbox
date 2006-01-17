Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWAQVBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWAQVBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWAQVBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:01:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46018
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964835AbWAQVBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:01:51 -0500
Date: Tue, 17 Jan 2006 12:58:09 -0800 (PST)
Message-Id: <20060117.125809.29713916.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, asun@darksunrising.com
Subject: Re: PATCH: cassini printk format warning
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1137523175.14135.84.camel@localhost.localdomain>
References: <1137523175.14135.84.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 17 Jan 2006 18:39:34 +0000

> compwb is u64, %lx is not u64.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

%llx is not u64 either, you have to use %llx and a "long long" cast to
get it right on all cases since several 64-bit platforms define u64 as
simply "unsigned long".
