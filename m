Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUDPWGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbUDPWEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:04:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25542 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263875AbUDPV5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:57:11 -0400
Date: Fri, 16 Apr 2004 14:56:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: rol@witbe.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [2.6.5] Bad scheduling while atomic
Message-Id: <20040416145632.0b96a3c9.davem@redhat.com>
In-Reply-To: <20040416131633.1bfbfa4c@dell_ss3.pdx.osdl.net>
References: <200404161551.i3GFpD124970@tag.witbe.net>
	<20040416131633.1bfbfa4c@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 13:16:33 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Bring up/down network devices with lapbether causes scheduling while
> atomic (if preempt enabled).
> 
> The calls to rcu_read_lock are unnecessary since lapb_device_event 
> is called from notifier with the rtnetlink semaphore held, it is
> already protected from the labp_devices list changing.

Applied, thanks Stephen.
