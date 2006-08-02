Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWHBWTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWHBWTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWHBWTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:19:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37505
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932277AbWHBWTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:19:09 -0400
Date: Wed, 02 Aug 2006 15:19:06 -0700 (PDT)
Message-Id: <20060802.151906.21953222.davem@davemloft.net>
To: cxzhang@us.ibm.com
Cc: catalin.marinas@gmail.com, cxzhang@watson.ibm.com, czhang.us@gmail.com,
       jmorris@namei.org, linux-kernel@vger.kernel.org,
       michal.k.k.piotrowski@gmail.com, netdev@vger.kernel.org,
       sds@tycho.nsa.org
Subject: Re: [Patch] kernel memory leak fix for af_unix datagram getpeersec
 patch
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF4882A75D.C66DD3D0-ON852571BE.007A0271-852571BE.007A82C3@us.ibm.com>
References: <20060802.143204.16511279.davem@davemloft.net>
	<OF4882A75D.C66DD3D0-ON852571BE.007A0271-852571BE.007A82C3@us.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaolan Zhang <cxzhang@us.ibm.com>
Date: Wed, 2 Aug 2006 18:18:07 -0400

> I did test it with CONFIG_SECURITY disabled, but did not catch the warning 
> -- I verified that the build completes with a valid vmlinux image.  There 
> are many warnings (device drivers, and others) during the build and I 
> didn't do a grep to find which one is specific to my patch.  Next time 
> I'll do a diff on warnings too.

Some platforms build their platform code under arch/${ARCH}/foo with
-Werror added to CFLAGS, sparc64 is one such platform.  So the build
did break for me.
