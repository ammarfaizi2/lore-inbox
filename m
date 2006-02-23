Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWBWLhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWBWLhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWBWLhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:37:23 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:19124 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750924AbWBWLhX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:37:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
Subject: Re: isolcpus weirdness
Date: Thu, 23 Feb 2006 22:37:13 +1100
User-Agent: KMail/1.9.1
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
References: <1140614487.13155.20.camel@localhost.localdomain> <200602232100.46551.kernel@kolivas.org> <1140691905.8314.21.camel@localhost.localdomain>
In-Reply-To: <1140691905.8314.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602232237.13470.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 21:51, Emmanuel Pacaud wrote:
> Le jeudi 23 février 2006 à 21:00 +1100, Con Kolivas a écrit :
> > On Thursday 23 February 2006 20:55, Emmanuel Pacaud wrote:
> > > Le mercredi 22 fÃ©vrier 2006 Ã  22:18 +0100, Frederik Deweerdt a 
Ã©crit :
> > > > On Wed, Feb 22, 2006 at 02:21:27PM +0100, Emmanuel Pacaud wrote:
> > > > > What's wrong ?
> > > >
> > > > Are you able to reproduce the same behaviour after disabling HT in
> > > > the kernel config?
> > >
> > > I think HT is disabled in kernel config, since I only see 2 cpus.
> > >
> > > In fact, I've tried to enable HT, but did'nt succeed. HT is enabled in
> > > BIOS, but I'm not sure about exact things I must set at kernel config
> > > level for hyperthreading. I've tried to set/unset CONFIG_SCHED_SMT, but
> > > that changes nothing (no hyperthreading, isolated cpu is always cpu0).
> > >
> > > Here's attached my config file.
> >
> > CONFIG_ACPI is not set
> >
> > You need ACPI to enumerate hyperthread siblings. That's why HT never gets
> > enabled for you.
>
> Following your advice, I've set CONFIG_ACPI, and now, isolcpus works
> fine, when hyperthreading is activated.
>
> But, I'm trying to build a real time system where hyperthreading is not
> desired. So, I've tried to disable HT in BIOS, and the result is the
> same as when ACPI is not enabled in kernel config: isolated cpu is
> always cpu0.
>
> On the same machine, which is originally a Scientific Linux 4, I've
> tried with distribution supplied kernel (a customized 2.6.9 with smp/HT
> enabled): isolcpus works fine, even with HT disabled at BIOS level.

Sorry I was only explaining why hyperthreading wasn't working with your 
config. I don't know anything about your problem specifically.

Cheers,
Con
