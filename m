Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWARWSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWARWSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWARWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:18:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27369
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932559AbWARWSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:18:43 -0500
Date: Wed, 18 Jan 2006 14:18:41 -0800 (PST)
Message-Id: <20060118.141841.87446048.davem@davemloft.net>
To: stern@rowland.harvard.edu
Cc: bcrl@kvack.org, akpm@osdl.org, sekharan@us.ibm.com, kaos@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] Notifier chain update
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.44L0.0601181706210.14089-100000@iolanthe.rowland.org>
References: <20060118220122.GH16285@kvack.org>
	<Pine.LNX.4.44L0.0601181706210.14089-100000@iolanthe.rowland.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 18 Jan 2006 17:09:10 -0500 (EST)

> Do you have a better proposal for a way to prevent blocking notifier 
> chains from being modified while in use?  Or would you prefer to rewrite 
> all the callout routines that currently block, so that all the notifier 
> chains can be made atomic and we don't need the blocking notifier API?

I think if the user needs special locking, they should implement
it.

If you need to block, take a mutex around the notifier calls.
(I nearly typed semaphore there, sorry Ingo! :-)
