Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbTIEWFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTIEWFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:05:34 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55693 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262561AbTIEWF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:05:27 -0400
Date: Fri, 5 Sep 2003 23:03:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] idle using PNI monitor/mwait (take 2)
Message-ID: <20030905220330.GA6900@mail.jlokier.co.uk>
References: <7F740D512C7C1046AB53446D3720017304AF0D@scsmsx402.sc.intel.com> <20030905211428.GB6019@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905211428.GB6019@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> local_irq_disable() isn't required in the monitor/mwait loop, because
> you check need_resched between the monitor and mwait.  (If Intel had
> implemented monitor+mwait as a single instruction, then you'd need it).
> 
> So you can remove it from your loop.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Excuse me, I hadn't looked at your code closely.  Everything I said up
to that last line is fine.  But the last line doesn't apply because
you don't have a local_irq_disable().

You can remove your local_irq_enable() instead, if you want, but for
a different reason.  That one _is_ defensive. :)

-- Jamie
