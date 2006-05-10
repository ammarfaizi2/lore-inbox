Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWEJWZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWEJWZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWEJWZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:25:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23724
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750869AbWEJWZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:25:17 -0400
Date: Wed, 10 May 2006 15:25:02 -0700 (PDT)
Message-Id: <20060510.152502.11682204.davem@davemloft.net>
To: paulus@samba.org
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
References: <20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
	<17506.21908.857189.645889@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 11 May 2006 07:05:24 +1000

> No, Richard has a point, it's not the value that is the concern, it's
> the address, which gcc could assume is still valid after a barrier.
> Drat.

Oh right, and that's currently part of why we obfuscate the
address computation with the RELOC_HIDE() buisness.

Once we expose what's really going on with something like
__thread, gcc can now be "smart" about it.
