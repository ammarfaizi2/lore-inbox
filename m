Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWEJGWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWEJGWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 02:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWEJGWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 02:22:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37354
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964827AbWEJGWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 02:22:15 -0400
Date: Tue, 09 May 2006 23:22:15 -0700 (PDT)
Message-Id: <20060509.232215.69573210.davem@davemloft.net>
To: olof@lixom.net
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060510051649.GD1794@lixom.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>
Date: Wed, 10 May 2006 00:16:50 -0500

> It would be interesting to see benchmarks of how much it improves
> things. I guess it doesn't really get interesting until after the paca
> gets removed though, due to the added mfsprg's.

When I moved the per-cpu base into a fixed register on sparc64,
it definitely showed up on the micro-benchmarks because this
shrunk the .text a lot in that case.
