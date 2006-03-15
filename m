Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWCOV6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWCOV6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCOV6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:58:05 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57743
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751123AbWCOV6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:58:04 -0500
Date: Wed, 15 Mar 2006 13:57:50 -0800 (PST)
Message-Id: <20060315.135750.00709244.davem@davemloft.net>
To: arjan@infradead.org
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com, akpm@osdl.org, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1142452665.3021.43.camel@laptopd505.fenrus.org>
References: <20060315193114.GA7465@in.ibm.com>
	<1142452665.3021.43.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Wed, 15 Mar 2006 20:57:45 +0100

> please use dma_addr_t then instead of unsigned long long
> 
> this is the right size on all platforms afaik (could a ppc64 person
> verify this?> ;)

Nope, it's 32-bit on Sparc64 for example and we definitely
want to support 64-bit BARs there.

