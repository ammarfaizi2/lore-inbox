Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318109AbSHWJo5>; Fri, 23 Aug 2002 05:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSHWJo5>; Fri, 23 Aug 2002 05:44:57 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:56081 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318109AbSHWJo4>; Fri, 23 Aug 2002 05:44:56 -0400
Date: Fri, 23 Aug 2002 10:49:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Tweedie <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] 2.4.20-pre4/ext3: Fix "buffer_jdirty" assert failure.
Message-ID: <20020823104905.B12076@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Tweedie <sct@redhat.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <200208222319.g7MNJaS09086@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208222319.g7MNJaS09086@sisko.scot.redhat.com>; from sct@redhat.com on Fri, Aug 23, 2002 at 12:19:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	int was_dirty = 0;
> +
>  	assert_spin_locked(&journal_datalist_lock);
>  #ifdef __SMP__
>  	J_ASSERT_JH(jh, current->lock_depth >= 0);
>  #endif

Umm, __SMP__ is never defined in 2.4..

