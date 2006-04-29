Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWD2LFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWD2LFK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 07:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWD2LFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 07:05:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:20871 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750708AbWD2LFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 07:05:08 -0400
From: Andi Kleen <ak@suse.de>
To: minyard@acm.org
Subject: Re: [PATCH] x86_64: fix die_lock nesting
Date: Sat, 29 Apr 2006 12:57:10 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060426205307.GA7505@i2.minyard.local>
In-Reply-To: <20060426205307.GA7505@i2.minyard.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604291257.11186.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 22:53, Corey Minyard wrote:


> The oops_begin() function in x86_64 would only conditionally claim
> the die_lock if the call is nested, but oops_end() would always
> release the spinlock. This patch adds a nest count for the die lock
> so that the release of the lock is only done on the final oops_end().

Merged thanks.

-Andi
