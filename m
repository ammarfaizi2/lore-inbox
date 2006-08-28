Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWH1RYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWH1RYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWH1RYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:24:13 -0400
Received: from science.horizon.com ([192.35.100.1]:6713 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750756AbWH1RYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:24:12 -0400
Date: 28 Aug 2006 13:24:10 -0400
Message-ID: <20060828172410.30776.qmail@science.horizon.com>
From: linux@horizon.com
To: alan@lxorguk.ukuu.org.uk, linux-os@analogic.com
Subject: Re: Serial custom speed deprecated?
Cc: linux-kernel@vger.kernel.org, linux@horizon.com
In-Reply-To: <1156784494.6271.32.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The state
> 
> 	(flag & CBAUD) == (CBAUDEX|0)
> 
> is not currently used
> 
> CBAUDEX|1 .. CBAUDX|15 are used as are 0-15.

a) thank you; I've been wondering why so many people seem unable to see
   the obvious.

b) I should mention, on the Alpha, CBAUDEX is defined as 0, and the used
   states are 0..30, so the spare state is 31

   But again, there *is* a spare state that can be used when a custom
   baud rate is queried via the backward-compatible inerface.
