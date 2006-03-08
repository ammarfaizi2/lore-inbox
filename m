Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWCHC5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWCHC5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWCHC5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:57:52 -0500
Received: from kanga.kvack.org ([66.96.29.28]:56457 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932388AbWCHC5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:57:51 -0500
Date: Tue, 7 Mar 2006 21:52:27 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] i386 spinlocks: disable interrupts only if we enabled them
Message-ID: <20060308025227.GP5410@kvack.org>
References: <200603071837_MC3-1-BA13-E5FB@compuserve.com> <20060307161550.27941df5.akpm@osdl.org> <20060308004308.GA16069@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308004308.GA16069@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 01:43:08AM +0100, Ingo Molnar wrote:
> we dont inline that code anymore. So i think the optimization is fine.

Why is that?  It adds memory traffic that has to be synchronized 
before the lock occurs and clobbered registers now in the caller.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
