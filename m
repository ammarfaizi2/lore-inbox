Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWF1WyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWF1WyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWF1WyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:54:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751652AbWF1WyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:54:14 -0400
Date: Wed, 28 Jun 2006 15:54:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
cc: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix kbuild module names (was: Re: oom-killer problem)
In-Reply-To: <200606281706.15514.daniel.ritz-ml@swissonline.ch>
Message-ID: <Pine.LNX.4.64.0606281552190.12404@g5.osdl.org>
References: <200606281706.15514.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jun 2006, Daniel Ritz wrote:
>
> had a look again. this one on top of "kbuild: fix make -rR breakage" (ie. revert
> the revert) should fix the module nameing.
> 
> Sam if you agree, please add your signed-off-by and forward to Linus.

Btw, I suspect I was wrong on the use of basename.

Yeah, you can do it carefully with that $(patsubst %.mod,%,..) thing, but 
boy is that ugly and hard to read. Since the whole point was to hopefully 
be safer, being "ugly and hard to read" is not exactly good, and I suspect 
the original $(basename ..) was simply better.

		Linus
