Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWFLJVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWFLJVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWFLJVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:21:07 -0400
Received: from www.tglx.de ([213.239.205.147]:35756 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751243AbWFLJVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:21:06 -0400
Subject: Re: 2.6.17-rc6-rt3
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1150104040.3835.3.camel@frecb000686>
References: <20060610082406.GA31985@elte.hu>
	 <1150104040.3835.3.camel@frecb000686>
Content-Type: text/plain; charset=utf-8
Date: Mon, 12 Jun 2006 11:21:58 +0200
Message-Id: <1150104118.5257.219.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 11:20 +0200, Sébastien Dugué wrote:
> > 
> > I think all of the regressions reported against rt1 are fixed, please 
> > re-report if any of them is still unfixed.
> > 
> 
>   Great, boots fine on my dual Xeon and solves the ping problem I was
> having.
> 
>   Thomas, any hint at what was going on?

I missed some modificatons in the networking code when I did the forward
to 2.6.17-rc6. The network softirq was raised, but the thread not woken
up.

	tglx


