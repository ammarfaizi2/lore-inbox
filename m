Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbUKFAH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUKFAH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 19:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKFAH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 19:07:56 -0500
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:35053 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261279AbUKFAHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 19:07:49 -0500
Date: Fri, 5 Nov 2004 18:06:02 -0600
From: Andy Warner <andyw@pobox.com>
To: Brad Campbell <brad@wasp.net.au>
Cc: Andy Warner <andyw@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [SATA] status report, libata-dev queue updated
Message-ID: <20041105180602.D31715@florence.linkmargin.com>
References: <20041105100049.GA31653@havoc.gtf.org> <418BCED3.1030600@wasp.net.au> <20041105132613.A30910@florence.linkmargin.com> <418BD814.807@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <418BD814.807@wasp.net.au>; from brad@wasp.net.au on Fri, Nov 05, 2004 at 11:44:20PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> Andy Warner wrote:
> > Brad Campbell wrote:
> > 
> >>[...]
> >>Read that as "I have tried really, really hard to break it and as yet been unable to".
> > 
> > 
> > Is your system SMP ? I'm actively tracking a problem now with
> > pass-thru behaviour (via /dev/sg* ) on SMP systems.
> 
> Nope, sorry. Only lowly UP here.

I can confirm that there is some sort of problem with
PIO and SMP. Either exercising only DMA commands, or booting
with maxcpus=1 avoids the problem. At present, I suspect
the PIO task and/or state machine, but I'm still investigating.

I doubt this problem will occur unless you have concurrent
PIO access to different controllers on an SMP system.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
