Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268450AbUIBQIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268450AbUIBQIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbUIBQIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:08:35 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:55249 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S268538AbUIBQHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:07:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.17710.288331.906507@gargle.gargle.HOWL>
Date: Thu, 2 Sep 2004 12:07:10 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <stoffel@lucent.com>, Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       Romano Giannetti <romano@dea.icai.upco.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Driver retries disk errors.
In-Reply-To: <1094137165.5486.0.camel@localhost.localdomain>
References: <20040830163931.GA4295@bitwizard.nl>
	<1093952715.32684.12.camel@localhost.localdomain>
	<20040831135403.GB2854@bitwizard.nl>
	<1093961570.597.2.camel@localhost.localdomain>
	<20040831155653.GD17261@harddisk-recovery.com>
	<1093965233.599.8.camel@localhost.localdomain>
	<20040831170016.GF17261@harddisk-recovery.com>
	<1093968767.597.14.camel@localhost.localdomain>
	<20040901152817.GA4375@pern.dea.icai.upco.es>
	<1094049877.2787.1.camel@localhost.localdomain>
	<20040901231434.GD28809@bitwizard.nl>
	<1094117369.4852.15.camel@localhost.localdomain>
	<16695.11922.71461.528204@gargle.gargle.HOWL>
	<1094137165.5486.0.camel@localhost.localdomain>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan> On Iau, 2004-09-02 at 15:30, John Stoffel wrote:
>> I really think that we need some way to keep such deadlocks from
>> happening.  I really dislike having a device lockup a user application
>> so hard that it can't be exited.  There's no real reason we should be
>> doing this any more.  If we have to, let the user kill it and just
>> have the kernel make it into a zombie, but at least let the user kill
>> it off.

Alan> If you had to reboot file a bug, none of the block error
Alan> recovery code or below should ever hang indefinitely.

Once I can reproduce it reliably, I'll send a better report.  I've
been holding off on my comments til now, but got caught up in the
moment.  

I also know now that it should timeout and come back to life.  I even
had a back trace on the hung process, but didn't save it.  Mea cupla.
