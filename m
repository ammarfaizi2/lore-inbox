Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVAOC6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVAOC6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVAOC6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:58:11 -0500
Received: from evtexc08.relay.danahertm.com ([129.196.229.155]:19132 "EHLO
	evtexc08.relay.danahertm.com") by vger.kernel.org with ESMTP
	id S262169AbVAOC6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:58:00 -0500
Date: Fri, 14 Jan 2005 18:58:11 -0800 (PST)
From: David Dyck <david.dyck@fluke.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Steffen Moser <lists@steffen-moser.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-rc2
In-Reply-To: <20050114231712.GH3336@logos.cnet>
Message-ID: <Pine.LNX.4.51.0501141853270.222@dd.tc.fluke.com>
References: <20050112151334.GC32024@logos.cnet> <20050114225555.GA17714@steffen-moser.de>
 <20050114231712.GH3336@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Jan 2005 03:02:14.0659 (UTC) FILETIME=[9D7B8D30:01C4FAAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005 at 21:17 -0200, Marcelo Tosatti <marcelo.tosatti@cyclad...:

> David, this also fix your problem.


Sorry, no

I tried your patch to drivers/char/tty_io.c
(using EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL)

My first test (apply the patch, make bzImage and modules again
results in the same errors as before

# insmod $PWD/cyclades.o
/lib/modules/2.4.29-rc2/kernel/drivers/char/cyclades.o: unresolved symbol tty_ldisc_flush
/lib/modules/2.4.29-rc2/kernel/drivers/char/cyclades.o: unresolved symbol tty_wakeup

$ grep tty_ldisc_flush /proc/ksyms
c01db0dc tty_ldisc_flush_R__ver_tty_ldisc_flush


 heading back to 2.4.29-pre2...
     David

