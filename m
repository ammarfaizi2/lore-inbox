Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWHSU6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWHSU6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 16:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWHSU6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 16:58:43 -0400
Received: from ns.suse.de ([195.135.220.2]:42732 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422781AbWHSU6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 16:58:42 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] block: fix queue bounce limit calculation
Date: Sat, 19 Aug 2006 22:58:17 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
References: <200608190612_MC3-1-C895-98A8@compuserve.com>
In-Reply-To: <200608190612_MC3-1-C895-98A8@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608192258.17430.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 12:11, Chuck Ebbert wrote:
> Queue bounce should start after the max page, not on it.

The page with memory 0xffffffff...0xffffffff+4096 is already
beyond the limit. And 0xffffffff's PFN is 0xffffffff>>PAGE_SHIFT.

I don't see how the patch is correct.

-Andi

