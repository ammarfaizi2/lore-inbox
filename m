Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWA3KMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWA3KMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWA3KMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:12:01 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:55507
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932197AbWA3KMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:12:00 -0500
Message-Id: <43DDF497.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 30 Jan 2006 11:12:23 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Arjan Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] double fault enhancements
References: <43DDF050.76F0.0078.0@novell.com> <1138615114.2977.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1138615114.2977.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I would hope TSS and such remain in the kernel static space, because
>those are the kind of things I'd like to be read only over time...

I'm not sure what you're trying to say. A TSS can't possibly be read-only, as the processor will need to write to it
any time it gets used.

>Also the last chunk of your patch has nothing to do with what you
>describe here... and seems sort of suprious. (it might be a useful
>cleanup, but it should be independent)

It is relevant, for the preprocessor pseudo-assertion in cpu_init() to work. Anyway, I submitted the THREAD_ORDER
introduction as a separate cleanup-like (as you suggest) patch before, without getting any positive or negative
responses back...

Jan

