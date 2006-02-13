Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWBMLia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWBMLia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWBMLia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:38:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:26078 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751095AbWBMLia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:38:30 -0500
Date: Mon, 13 Feb 2006 12:38:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
In-Reply-To: <1139830116.2480.464.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602131235180.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
 <1139830116.2480.464.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Thomas Gleixner wrote:

> > A const for arguments which are passed by value is completely ignored by
> > gcc. It has only an effect on local variables and even here gcc doesn't
> > need it either to produce better code.
> 
> NACK - gcc3 produces smaller code with the const - only gcc4 fixed that

That would would be a compiler problem, these const _are_ bogus.

> Also this is neither a regression nor a bug and therefor not required
> for 2.6.16.

Well, hrtimer was merged a bit suddenly for me, so I never had a chance 
for a detailed review and this patch doesn't break anything either.

bye, Roman
