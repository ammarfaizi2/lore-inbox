Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVAISON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVAISON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 13:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVAISON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 13:14:13 -0500
Received: from one.firstfloor.org ([213.235.205.2]:52414 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261659AbVAISOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 13:14:11 -0500
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Notify user of MCE events (updated)
References: <Pine.LNX.4.61.0501082121380.13639@montezuma.fsmlabs.com>
	<m1sm5av9fd.fsf@muc.de>
	<Pine.LNX.4.61.0501091005590.13639@montezuma.fsmlabs.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 09 Jan 2005 19:14:09 +0100
In-Reply-To: <Pine.LNX.4.61.0501091005590.13639@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Sun, 9 Jan 2005 10:10:11 -0700 (MST)")
Message-ID: <m1fz1av5am.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:
> +	 */
> +	if (notify_user && console_logged) {
> +		notify_user = 0;
> +		clear_bit(0, &console_logged);
> +		printk(KERN_EMERG "Machine check exception logged\n");

Another suggestion: don't make this KERN_EMERG. Make it KERN_INFO. 
Logged errors are usually correct, so there is no need for an 
emergency.

Also since these are not always exceptions (but can be read from
the polling timer) I would call them "machine check events" 

-Andi
