Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWGKR0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWGKR0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGKR0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:26:21 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:47497 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751131AbWGKR0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:26:21 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: [PATCH] fdset's leakage
Date: Tue, 11 Jul 2006 19:26:36 +0200
User-Agent: KMail/1.9.1
Cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, devel@openvz.org, kuznet@ms2.inr.ac.ru
References: <44B258E3.7070708@openvz.org> <44B369BF.6000104@openvz.org> <Pine.LNX.4.58.0607110912490.16191@shell3.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0607110912490.16191@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111926.36388.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 18:13, Vadim Lobanov wrote:
> > unsinged long round_up_pow_of_two(unsigned long x)
> > {
> >   unsigned long res = 1 << BITS_PER_LONG;
>
> You'll get a zero here. Should be 1 << (BITS_PER_LONG - 1).
>

Nope. It wont work on 64 bits platform :)

You want  1UL << (BITS_PER_LONG - 1).

But the roundup_pow_of_two() function is already defined in 
include/linux/kernel.h and uses fls_long()

Eric
