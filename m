Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031308AbWK3UGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031308AbWK3UGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031303AbWK3UGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:06:24 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:21656
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031292AbWK3UGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:06:23 -0500
Date: Thu, 30 Nov 2006 12:06:24 -0800 (PST)
Message-Id: <20061130.120624.107938624.davem@davemloft.net>
To: wenji@fnal.gov
Cc: akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <HNEBLGGMEGLPMPPDOPMGMEAMCGAA.wenji@fnal.gov>
References: <20061129.181950.31643130.davem@davemloft.net>
	<HNEBLGGMEGLPMPPDOPMGMEAMCGAA.wenji@fnal.gov>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenji Wu <wenji@fnal.gov>
Date: Thu, 30 Nov 2006 10:08:22 -0600

> If the higher prioirty processes become runnable (e.g., interactive
> process), you better yield the CPU, instead of continuing this process. If
> it is the case that the process within tcp_recvmsg() is expriring, then, you
> can continue the process to go ahead to process backlog.

Yes, I understand this, and I made that point in one of my
replies to Ingo Molnar last night.

The only seemingly remaining possibility is to find a way to allow
input packet processing, at least enough to emit ACKs, during
tcp_recvmsg() processing.

