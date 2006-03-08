Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWCHG55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWCHG55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 01:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWCHG55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 01:57:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64654 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751742AbWCHG54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 01:57:56 -0500
Date: Tue, 7 Mar 2006 22:55:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: mingo@elte.hu, 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [patch] i386 spinlocks: disable interrupts only if we enabled
 them
Message-Id: <20060307225556.75cee661.akpm@osdl.org>
In-Reply-To: <20060308025227.GP5410@kvack.org>
References: <200603071837_MC3-1-BA13-E5FB@compuserve.com>
	<20060307161550.27941df5.akpm@osdl.org>
	<20060308004308.GA16069@elte.hu>
	<20060308025227.GP5410@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> On Wed, Mar 08, 2006 at 01:43:08AM +0100, Ingo Molnar wrote:
>  > we dont inline that code anymore. So i think the optimization is fine.
> 
>  Why is that?  It adds memory traffic that has to be synchronized 
>  before the lock occurs and clobbered registers now in the caller.

Is the inlined lock;decb+jns likely to worsen the text size?  I doubt it. 
Overall text will get bigger due to the out-of-line stuff, but that's OK.

I'm sure we went over all this, but I don't recall the thinking.
