Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318278AbSGRRbP>; Thu, 18 Jul 2002 13:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318280AbSGRRbP>; Thu, 18 Jul 2002 13:31:15 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:15368 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S318278AbSGRRbO>; Thu, 18 Jul 2002 13:31:14 -0400
Date: Thu, 18 Jul 2002 18:36:13 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Robert Love <rml@tech9.net>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027009865.1555.105.camel@sinai>
Message-ID: <Pine.LNX.4.30.0207181806220.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2002, Robert Love wrote:

> I do not see anything in this email related to the issue at hand.

You solve a problem and introduce a potentially more serious one.
Strict overcommit is requisite but not satisfactory.

> Specifically, what livelock situation are you insinuating?  If we only
> allow allocation that are met by the backing store, we cannot get
> anywhere near OOM.

This is what I would do first [make sure you don't hit any resource,
malloc, kernel memory mapping, etc limits -- this is a simulation that
must eat all available memory continually]:
main(){void *x;while(1)if(x=malloc(4096))memset(x,666,4096);}

When the above used up all the memory try to ssh/login to the box as
root and clean up the mess. Can you do it?

	Szaka

