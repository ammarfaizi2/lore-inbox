Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVAWK7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVAWK7G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVAWK7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:59:06 -0500
Received: from mail.suse.de ([195.135.220.2]:3492 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261288AbVAWK7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:59:04 -0500
Date: Sun, 23 Jan 2005 11:59:03 +0100
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, ak@suse.de
Subject: Re: [PATCH] x86_64: use UL on TASK_SIZE
Message-ID: <20050123105903.GA2788@wotan.suse.de>
References: <20050122225617.35d1c6ac.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122225617.35d1c6ac.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 10:56:17PM -0800, Randy.Dunlap wrote:
> 
> Use UL on large constant (kills 3214 sparse warnings :)
> 
> include/linux/sched.h:1150:18: warning: constant 0x800000000000 is so big it is long

Sounds more like a sparse bug to me.  The C99 standard says the type
of the constant is the first in which the constant can be represented.
And that list includes unsigned long and even unsigned long long.

-Andi
