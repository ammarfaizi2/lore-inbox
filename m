Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752156AbWCJArI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbWCJArI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCJArH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:47:07 -0500
Received: from mx.pathscale.com ([64.160.42.68]:38799 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752149AbWCJArD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:47:03 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adaslprcelg.fsf@cisco.com>
References: <28bb276205de498d0b5c.1141950939@eng-12.pathscale.com>
	 <adaslprcelg.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 16:47:02 -0800
Message-Id: <1141951622.10693.85.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 16:45 -0800, Roland Dreier wrote:

> So why is ipath_sma_alive an atomic_t (and why isn't it static)?
> You never modify ipath_sma_alive outside of your spinlock, so I don't
> see what having it be atomic buys you.

It's read outside of this file, without a lock held.

	<b

