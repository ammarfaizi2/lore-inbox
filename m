Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWBUPen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWBUPen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWBUPen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:34:43 -0500
Received: from kanga.kvack.org ([66.96.29.28]:18355 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932535AbWBUPem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:34:42 -0500
Date: Tue, 21 Feb 2006 10:29:49 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: David Golombek <daveg@permabit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 hangs, no information on console or serial port
Message-ID: <20060221152949.GA31273@kvack.org>
References: <7yirr8hh0z.fsf@questionably-configured.permabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7yirr8hh0z.fsf@questionably-configured.permabit.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 10:23:56AM -0500, David Golombek wrote:
> Any suggestions as to how we might debug this or possible causes would
> be greatly appreciated.

Have you tried turning on the NMI watchdog (nmi_watchdog=1)?  It should 
be able to kick the machine out of the locked state, as these symptoms 
would hint at a spinlock deadlock with interrupts disabled.  Also, try 
to reproduce on the latest 2.4.33pre.  That said, for an io intensive 
workload like you're running, 2.6 is much better, especially for systems 
using highmem.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
