Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUJ1TnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUJ1TnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbUJ1TnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:43:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45725 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261980AbUJ1TjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:39:07 -0400
Date: Thu, 28 Oct 2004 12:20:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: ncunningham@linuxmail.org, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fixing MTRR smp breakage and suspending sysdevs.
Message-ID: <20041028102013.GA7883@openzaurus.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD3057569A2A2@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057569A2A2@pdsmsx402.ccr.corp.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Is the problem MTRR resume must be with IRQ enabled, right? Could we
> >> implement a method sysdev resume with IRQ enabled? MTRR driver isn't
> >> the
> >
> >MTRR does not deserve to be sysdev. It is not essential for the
> >system, it only makes it slow.
> It's a CPU driver, cpufreq driver is the same.

Well, it drives part of cpu. Fortunately that part of cpu is not required for
other drivers. cpufreq definitely should not be sysdev. If mtrr is not needed for drivers (I think it is not), it should not be a sysdev.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

