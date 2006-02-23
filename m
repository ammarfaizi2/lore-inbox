Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWBWKBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWBWKBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWBWKBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:01:01 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:60119 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751701AbWBWKBA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:01:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
Subject: Re: isolcpus weirdness
Date: Thu, 23 Feb 2006 21:00:45 +1100
User-Agent: KMail/1.9.1
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
References: <1140614487.13155.20.camel@localhost.localdomain> <20060222211817.GA13488@silenus.home.res> <1140688532.8314.10.camel@localhost.localdomain>
In-Reply-To: <1140688532.8314.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602232100.46551.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 20:55, Emmanuel Pacaud wrote:
> Le mercredi 22 février 2006 à 22:18 +0100, Frederik Deweerdt a écrit :
> > On Wed, Feb 22, 2006 at 02:21:27PM +0100, Emmanuel Pacaud wrote:
> > > What's wrong ?
> >
> > Are you able to reproduce the same behaviour after disabling HT in
> > the kernel config?
>
> I think HT is disabled in kernel config, since I only see 2 cpus.
>
> In fact, I've tried to enable HT, but did'nt succeed. HT is enabled in
> BIOS, but I'm not sure about exact things I must set at kernel config
> level for hyperthreading. I've tried to set/unset CONFIG_SCHED_SMT, but
> that changes nothing (no hyperthreading, isolated cpu is always cpu0).
>
> Here's attached my config file.

CONFIG_ACPI is not set

You need ACPI to enumerate hyperthread siblings. That's why HT never gets 
enabled for you.

Cheers,
Con
