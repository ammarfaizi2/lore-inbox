Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264710AbUEEP7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbUEEP7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 11:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbUEEP7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 11:59:15 -0400
Received: from holomorphy.com ([207.189.100.168]:32401 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264710AbUEEP7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 11:59:14 -0400
Date: Wed, 5 May 2004 08:59:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040505155906.GN1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <4098CFEB.468E6326@tv-sign.ru> <4098DB41.1A7FC5DF@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4098DB41.1A7FC5DF@tv-sign.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 04:17:05PM +0400, Oleg Nesterov wrote:
> also, exclusive wakeups have no problems, and process
> waiting in wait_on_page_writeback() won't be waken
> by unlock_page(). it will be waken _only_ when that
> bit will be cleared.

I didn't feel obligated to answer the last time since I suspected you'd
not press the issue after realizing the error.

The object isn't passed down to the wake function at all, so it can't
avoid falsely scheduling waiters on the wrong objects and/or bits.


-- wli
