Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVAIS1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVAIS1k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 13:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVAIS1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 13:27:40 -0500
Received: from fsmlabs.com ([168.103.115.128]:45219 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261681AbVAIS1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 13:27:38 -0500
Date: Sun, 9 Jan 2005 11:27:20 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Notify user of MCE events (updated)
In-Reply-To: <m1fz1av5am.fsf@muc.de>
Message-ID: <Pine.LNX.4.61.0501091127030.13639@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501082121380.13639@montezuma.fsmlabs.com>
 <m1sm5av9fd.fsf@muc.de> <Pine.LNX.4.61.0501091005590.13639@montezuma.fsmlabs.com>
 <m1fz1av5am.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005, Andi Kleen wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:
> > +	 */
> > +	if (notify_user && console_logged) {
> > +		notify_user = 0;
> > +		clear_bit(0, &console_logged);
> > +		printk(KERN_EMERG "Machine check exception logged\n");
> 
> Another suggestion: don't make this KERN_EMERG. Make it KERN_INFO. 
> Logged errors are usually correct, so there is no need for an 
> emergency.
> 
> Also since these are not always exceptions (but can be read from
> the polling timer) I would call them "machine check events" 

Thanks for the comments, i've updated the patch.

