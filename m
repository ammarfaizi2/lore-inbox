Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWDYSXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWDYSXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWDYSXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:23:46 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:17832 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932280AbWDYSXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:23:45 -0400
Subject: Re: [PATCH] Profile likely/unlikely macros
From: Daniel Walker <dwalker@mvista.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hzhong@gmail.com
In-Reply-To: <444DF5B4.6030004@yahoo.com.au>
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>
	 <20060424200657.0af43d6a.akpm@osdl.org>  <444DF5B4.6030004@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 11:23:43 -0700
Message-Id: <1145989423.3674.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 20:11 +1000, Nick Piggin wrote:

> I guess it is so it can be used in NMIs and interrupts without turning
> interrupts off (so is somewhat lightweight).
> 
> But please Daniel, just use spinlocks and trylock. This is buggy because
> it doesn't get the required release consistency correct.


To use spinlock we would need to used the __raw_ types . As Hua
explained all of the vanilla spinlock calls use the unlikely macro. The
result is that we end up using atomic operations. So using them directly
seems like the cleanest method .

I'm not exactly sure what you mean by "release consistency" ?

Daniel

