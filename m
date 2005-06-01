Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVFAOnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVFAOnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVFAOnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:43:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45302 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261395AbVFAOns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:43:48 -0400
Date: Wed, 1 Jun 2005 07:43:43 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
In-Reply-To: <429DC99B.E88C6783@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0506010741060.23057-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Oleg Nesterov wrote:

> fifo? 2
> fifo? 1
> fifo? 0

plist_for_each() wasn't designed to be FIFO , as you've discovered. That's 
the slow method , you should test the fast method via pulling the nodes 
off the front of the list.

Daniel

