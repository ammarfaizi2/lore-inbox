Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267616AbUHEKFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267616AbUHEKFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267617AbUHEKFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:05:45 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:51681 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267616AbUHEKFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:05:44 -0400
Subject: Re: Solving suspend-level confusion
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091595811.5226.105.camel@gaston>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <1091587985.5226.74.camel@gaston>
	 <1091587929.3303.38.camel@laptop.cunninghams>
	 <1091592870.5226.80.camel@gaston>
	 <1091593555.3191.48.camel@laptop.cunninghams>
	 <1091595125.5227.96.camel@gaston>
	 <1091595258.3303.74.camel@laptop.cunninghams>
	 <1091595811.5226.105.camel@gaston>
Content-Type: text/plain
Message-Id: <1091698068.2964.164.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 05 Aug 2004 20:05:25 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-04 at 15:03, Benjamin Herrenschmidt wrote:
> That's where the whole confusion is indeed... and why we need to make
> that clear. The IDE driver will sleep the disk for 3 and keep it spinning
> for 4

Discovered the problem; another layer of confusion! I was using
PM_SUSPEND_DISK, which actually evaluates to 3, not 4 as I thought. Now
that I'm using the literal 4, it works fine.

Nigel

