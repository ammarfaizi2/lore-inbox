Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVCKRm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVCKRm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCKRm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:42:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:23255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261234AbVCKRmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:42:46 -0500
Date: Fri, 11 Mar 2005 09:37:24 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "leo.yuriev.ru" <leo@yuriev.ru>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Patrick McHardy <kaber@trash.net>, jamal <hadi@cyberus.ca>,
       Ben Greear <greearb@candelatech.com>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] updated, ethernet-bridge: update skb->priority in case
 forwarded frame has VLAN-header
Message-ID: <20050311093724.6c8b6a6d@dxpl.pdx.osdl.net>
In-Reply-To: <914610115.20050311172022@yuriev.ru>
References: <914610115.20050311172022@yuriev.ru>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 17:20:22 +0300
Leo Yuriev <leo@yuriev.ru> wrote:

> Kernel 2.6 (2.6.11)
> 
> When ethernet-bridge forward a packet and such ethernet-frame has
> VLAN-tag, bridge should update skb->prioriry for properly QoS
> handling. This small patch does this.
> 
> Based upon discussion during last week I added pskb_may_pull()
> checking and simple mapping from 802.1p/user_priority to skb->priority.
> 
> Patch-by: Leo Yuriev <leo@yuriev.ru>

Do this as an ebtables module please.
