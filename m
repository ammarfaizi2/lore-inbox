Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUI0P7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUI0P7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUI0P7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:59:34 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:61923 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266243AbUI0P7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:59:10 -0400
Message-ID: <35fb2e5904092708594f50f25d@mail.gmail.com>
Date: Mon, 27 Sep 2004 16:59:02 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Cc: Lars Marowsky-Bree <lmb@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040927133554.GD30956@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409230123.30858.thomas@habets.pp.se>
	 <20040923234520.GA7303@pclin040.win.tue.nl>
	 <1096031971.9791.26.camel@localhost.localdomain>
	 <200409242158.40054.thomas@habets.pp.se>
	 <1096060549.10797.10.camel@localhost.localdomain>
	 <20040927104120.GA30364@logos.cnet>
	 <20040927125441.GG3934@marowsky-bree.de>
	 <35fb2e590409270612524c5fb9@mail.gmail.com>
	 <20040927133554.GD30956@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004 10:35:54 -0300, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:

> On Mon, Sep 27, 2004 at 02:12:26PM +0100, Jon Masters wrote:

> > What would be wrong with having the page reclaim algorithms use one of
> > the low memory watermarks as a trigger to call in to userspace to
> > extend the swap available if possible? This is probably what Microsoft
> > et al do with their "Windows is extending your virtual memory

> You dont to change kernel code for that - make a script to monitor
> swap usage, as soon as it gets below a given watermark, you swapon
> whatever swapfile you want.

Assuming the machine's not swapping itself to death, but I suppose
you're right anyway. I'll have a look at writing something for proof
of concept.

Jon.
