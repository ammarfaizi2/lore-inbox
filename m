Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUHFAkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUHFAkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHFAkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:40:08 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:5539 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268028AbUHFAjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:39:55 -0400
From: David Brownell <david-b@pacbell.net>
To: ncunningham@linuxmail.org
Subject: Re: Solving suspend-level confusion
Date: Thu, 5 Aug 2004 17:32:04 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200408041829.45298.david-b@pacbell.net> <1091701150.2964.229.camel@laptop.cunninghams>
In-Reply-To: <1091701150.2964.229.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408051732.04920.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 03:19, Nigel Cunningham wrote:

> That's what my patch does. I kept the existing api untouched so that:
> 
> device_resume();
> 
> is actually a wrapper for
> 
> device_resume_tree(&default_device_tree);
> 
> Proof of the pudding coming :>

Sounds good.  Will it be possible to remove devices during
these tree operations?  Probably never the current one.

And (evil chuckle) how will it behave if two tasks are doing
that concurrently?  The no-overlap case would be fully
parallel, I'd hope!

- Dave
