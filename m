Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVCFVEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVCFVEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 16:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVCFVEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 16:04:35 -0500
Received: from coderock.org ([193.77.147.115]:40877 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261497AbVCFVEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 16:04:33 -0500
Date: Sun, 6 Mar 2005 22:04:26 +0100
From: Domen Puncer <domen@coderock.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: emoenke@gwdg.de, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 2/6] 12/34: cdrom/cdu31a: replace interruptible_sleep_on() with wait_event_interruptible()
Message-ID: <20050306210426.GA32564@nd47.coderock.org>
References: <20050306103155.4AC7D1F202@trashy.coderock.org> <422AECBF.7040507@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422AECBF.7040507@rainbow-software.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/05 12:42 +0100, Ondrej Zary wrote:
> domen@coderock.org wrote:
> >Use wait_event_interruptible() instead of the deprecated
> >interruptible_sleep_on(). The patch is straight-forward as the macros 
> >should result in the same execution. Patch is compile-tested (still throws 
> >out warnings
> >regarding {save,restore}_flags()).
> >
> >Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> >Signed-off-by: Domen Puncer <domen@coderock.org>
> 

Uh, this one escaped me, as schedule() (sleep_on) after cli() is clearly
wrong. Btw. what was the reason for this?

> I've posted a patch for the cdu31a driver some time ago that removes 
> almost all usage of interruptible_sleep_on() and also 
> {save,restore}_flags() - it uses semaphore instead.
> The only remaining code is in sony_sleep() function when using 
> IRQ-driven operation.
> 
> See http://lkml.org/lkml/2004/12/18/107
> The patch is big because I've messed with the formatting...

I looked at it, and rewrote some of it into smaller patches. If you don't
mind, can i send them to you for review and testing?


	Domen
