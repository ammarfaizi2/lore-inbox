Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWGLKuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWGLKuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 06:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWGLKuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 06:50:22 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:43631 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751245AbWGLKuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 06:50:16 -0400
Message-ID: <44B4D3D5.4070201@sw.ru>
Date: Wed, 12 Jul 2006 14:49:57 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
CC: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, devel@openvz.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fdset's leakage
References: <44B258E3.7070708@openvz.org> <20060711010104.16ed5d4b.akpm@osdl.org> <44B369BF.6000104@openvz.org> <Pine.LNX.4.58.0607110912490.16191@shell3.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0607110912490.16191@shell3.speakeasy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Your logic looks fine for me. Do we have already round_up_pow_of_two() function or
>>should we create it as something like:
>>unsinged long round_up_pow_of_two(unsigned long x)
>>{
>>  unsigned long res = 1 << BITS_PER_LONG;
> 
> 
> You'll get a zero here. Should be 1 << (BITS_PER_LONG - 1).
Good that so many people are watching when you even didn't write it yet :)))
Thanks!

Kirill
