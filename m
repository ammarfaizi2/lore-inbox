Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbUKHO0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUKHO0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUKHO0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:26:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:54692 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261664AbUKHO0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:26:49 -0500
Date: Mon, 8 Nov 2004 14:44:49 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108134448.GA2456@wotan.suse.de>
References: <20041107142445.GH14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107142445.GH14308@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you still reproduce this problem?
> If not, I'll suggest to apply the patch below which saves a few kB in 
> lib/string.o .

I would prefer to keep it because there is no guarantee in gcc
that it always inlines all string functions unless you pass
-minline-all-stringops. And with that the code would
be bloated much more than the few out of lined fallback
string functions.

Even if it works for you with your configuration it's just by luck.

-Andi
