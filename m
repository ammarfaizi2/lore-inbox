Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316986AbSFQUac>; Mon, 17 Jun 2002 16:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSFQU3T>; Mon, 17 Jun 2002 16:29:19 -0400
Received: from ns.suse.de ([213.95.15.193]:45326 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316995AbSFQU2L>;
	Mon, 17 Jun 2002 16:28:11 -0400
Date: Mon, 17 Jun 2002 22:28:12 +0200
From: Dave Jones <davej@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
Message-ID: <20020617222812.I758@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020617161434.D1457@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020617161434.D1457@redhat.com>; from bcrl@redhat.com on Mon, Jun 17, 2002 at 04:14:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 04:14:34PM -0400, Benjamin LaHaise wrote:
 > +#define add_wait_queue_cond(q, wait, cond) \
 > +	({							\
 > +		unsigned long flags;				\
 > +		int _raced = 0;					\
 > +		wq_write_lock_irqsave(&(q)->lock, flags);	\

I thought we killed off wq_write_lock_irqsave 1-2 kernels ago ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
