Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWAYQ7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWAYQ7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWAYQ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:59:42 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:19957 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932069AbWAYQ7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:59:41 -0500
Subject: Re: [patch, lock validator] fix uidhash_lock <-> RCU deadlock
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20060125142307.GA5427@elte.hu>
References: <20060125142307.GA5427@elte.hu>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 08:59:37 -0800
Message-Id: <1138208378.3992.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 15:23 +0100, Ingo Molnar wrote:
> RCU task-struct freeing can call free_uid(), which is taking 
> uidhash_lock - while other users of uidhash_lock are softirq-unsafe.
> 
> This bug was found by the lock validator i'm working on:

What is it doing exactly ?

Daniel

