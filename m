Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVDUTyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVDUTyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVDUTyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 15:54:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24568 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261825AbVDUTyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 15:54:52 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-00
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050421073537.GA1004@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <20050421073537.GA1004@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1114113288.19336.24.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Apr 2005 12:54:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 00:35, Ingo Molnar wrote:

> this is a merge to 2.6.12-rc3, plus the 'ping localhost' fix from 
> yang.yi@bmrtech.com.


We had some discussion about this one, there just need to be a softirqd
wakeup , the netif_rx_ni() call isn't really needed .

How about removing the softirqd wakeup from interrupt context, and move
it into the softirq scheduler. That would solve this situation and all
others like it .. Plus reduce worst case interrupt latency ..

Daniel

