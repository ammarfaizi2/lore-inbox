Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUB0Bju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUB0Bjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:39:36 -0500
Received: from fmr06.intel.com ([134.134.136.7]:3243 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261711AbUB0Bgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:36:52 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Why no interrupt priorities?
Date: Thu, 26 Feb 2004 17:36:34 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why no interrupt priorities?
Thread-Index: AcP8udTMMoVivhM8RT2r/6uqtKpkWwAF7CtA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Mark Gross" <mgross@linux.co.intel.com>, <arjanv@redhat.com>,
       "Tim Bird" <tim.bird@am.sony.com>
Cc: <root@chaos.analogic.com>, "linux kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Feb 2004 01:36:34.0388 (UTC) FILETIME=[22373140:01C3FCD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 26 February 2004 13:30, Arjan van de Ven wrote:
> > hardware IRQ priorities are useless for the linux model. In 
> linux, the
> > hardirq runs *very* briefly and then lets the softirq context do the
> > longer taking work. hardware irq priorities then don't matter really
> > because the hardirq's are hardly ever interrupted really, 
> and when they
> > are they cause a performance *loss* due to cache trashing. 
> The latency
> > added by waiting briefly is going to be really really short 
> for any sane
> > hardware.

Is the assumption that hardirq handlers are superfast also the reason
why Linux calls all handlers on a shared interrupt, even if the first
handler reports it was for its device?

-- Andy
