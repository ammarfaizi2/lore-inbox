Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUIBObb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUIBObb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268353AbUIBObb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:31:31 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:18855 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S268388AbUIBOaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:30:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.11922.71461.528204@gargle.gargle.HOWL>
Date: Thu, 2 Sep 2004 10:30:42 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       Romano Giannetti <romano@dea.icai.upco.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Driver retries disk errors.
In-Reply-To: <1094117369.4852.15.camel@localhost.localdomain>
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
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> that much would not sound abnormal. (seeks are about 10 times
>> as expensive on CDs). 8 times 8 seconds is a full minute. 

Alan> As I said media players need a way to turn it to no retry

I just ran into this with a scratched CDROM and the program 'grip'
which ended up requiring a reboot of my 2.6.8 kernel to get back
control of /dev/cdrom on my system.  Needless to say, I wasn't very
happy about this.

I really think that we need some way to keep such deadlocks from
happening.  I really dislike having a device lockup a user application
so hard that it can't be exited.  There's no real reason we should be
doing this any more.  If we have to, let the user kill it and just
have the kernel make it into a zombie, but at least let the user kill
it off.

John
