Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVI2Llu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVI2Llu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 07:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVI2Llu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 07:41:50 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31126 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932097AbVI2Llt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 07:41:49 -0400
Date: Thu, 29 Sep 2005 13:42:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: update rcurefs for RT
Message-ID: <20050929114235.GA638@elte.hu>
References: <1127845926.4004.22.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127845926.4004.22.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Make rcurefs compatible with RT w/o cmpxchg() .

> +static inline void init_rcurefs(void)
> +{
> +	int i;
> +	for (i=0; i < RCUREF_HASH_SIZE; i++) 
> +		SPIN_LOCK_UNLOCKED(__rcuref_hash[i]);

what the heck is this doing??? Patch reverted.

	Ingo
