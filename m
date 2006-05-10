Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWEJSU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWEJSU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWEJSU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:20:58 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:57439 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751490AbWEJSU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:20:58 -0400
Subject: Re: [PATCH] mm: cleanup swap unused warning
From: Daniel Walker <dwalker@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20060510043834.70f40ddc.akpm@osdl.org>
References: <200605102132.41217.kernel@kolivas.org>
	 <20060510043834.70f40ddc.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 10 May 2006 11:20:55 -0700
Message-Id: <1147285256.21536.132.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 04:38 -0700, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> >
> > Are there any users of swp_entry_t when CONFIG_SWAP is not defined?
> 
> Well there shouldn't be.  Making accesses to swp_entry_t.val fail to
> compile if !CONFIG_SWAP might be useful.

In mm/vmscan.c line 387 it defined swp_entry_t and sets val regardless
of CONFIG_SWAP , but the value never really gets used .. Showed up in my
warning reviews.

Daniel

