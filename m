Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUB0DG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 22:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUB0DG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 22:06:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:29327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261670AbUB0DGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 22:06:52 -0500
Date: Thu, 26 Feb 2004 19:02:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: mgross@linux.co.intel.com, arjanv@redhat.com, tim.bird@am.sony.com,
       root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
Message-Id: <20040226190259.7965cc76.rddunlap@osdl.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004 17:36:34 -0800 "Grover, Andrew" <andrew.grover@intel.com> wrote:

| > On Thursday 26 February 2004 13:30, Arjan van de Ven wrote:
| > > hardware IRQ priorities are useless for the linux model. In 
| > linux, the
| > > hardirq runs *very* briefly and then lets the softirq context do the
| > > longer taking work. hardware irq priorities then don't matter really
| > > because the hardirq's are hardly ever interrupted really, 
| > and when they
| > > are they cause a performance *loss* due to cache trashing. 
| > The latency
| > > added by waiting briefly is going to be really really short 
| > for any sane
| > > hardware.
| 
| Is the assumption that hardirq handlers are superfast also the reason
| why Linux calls all handlers on a shared interrupt, even if the first
| handler reports it was for its device?

Somehow I don't think that's the reasoning.

Is there a safe method to determine that there are no other pending
interrupts on one shared interrupt?  i.e., that other devices don't
also have interrupts pending?

--
~Randy
