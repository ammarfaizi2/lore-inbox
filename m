Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbUK2Jjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUK2Jjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 04:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUK2Jjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 04:39:40 -0500
Received: from levante.wiggy.net ([195.85.225.139]:4051 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261637AbUK2Jji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 04:39:38 -0500
Date: Mon, 29 Nov 2004 10:39:38 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about /dev/mem and /dev/kmem
Message-ID: <20041129093937.GN31995@wiggy.net>
Mail-Followup-To: Jim Nelson <james4765@verizon.net>,
	linux-kernel@vger.kernel.org
References: <41AA9E26.4070105@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AA9E26.4070105@verizon.net>
User-Agent: Mutt/1.5.6+20040722i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jim Nelson wrote:
> I was looking at some articles about rootkits on monolithic kernels, and 
> had a thought.  Would a kernel config option to disable write access to 
> /dev/mem and /dev/kmem be a workable idea?

Yes, but not a very useful one since it is an incomplete solution. You
can easily do something better using /proc/kernel/cap-bound (like
writing 0xFFFCFFFF into it).

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
