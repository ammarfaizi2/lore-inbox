Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWH1VXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWH1VXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWH1VXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:23:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:39847 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751517AbWH1VXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:23:21 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: divide error: 0000 in fib6_rule_match [Re: 2.6.18-rc4-mm3]
Date: Mon, 28 Aug 2006 23:22:48 +0200
User-Agent: KMail/1.9.3
Cc: Mattia Dongili <malattia@linux.it>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, netdev@vger.kernel.org
References: <20060826160922.3324a707.akpm@osdl.org> <20060828200716.GA4244@inferi.kami.home> <20060828132820.ae12ce4f.akpm@osdl.org>
In-Reply-To: <20060828132820.ae12ce4f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608282322.48307.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I cannot work out how the heck you got a divide instruction in
> fib6_rule_match().

This might be another symptom of the broken smp-alternatives patch.
It tended to randomly corrupt some instructions by inserting different
bytes which then crash in interesting ways.

I already sent a fix for that, but it's not in yet.

-Andi
