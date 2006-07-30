Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWG3RoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWG3RoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWG3RoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:44:04 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18171 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932397AbWG3RoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:44:03 -0400
Date: Sun, 30 Jul 2006 10:45:13 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
In-reply-to: <20060730160738.GB13377@irc.pl>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0607301043070.7932@montezuma.fsmlabs.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
References: <20060730120844.GA18293@outpost.ds9a.nl>
 <20060730160738.GB13377@irc.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006, Tomasz Torcz wrote:

> On Sun, Jul 30, 2006 at 02:08:44PM +0200, bert hubert wrote:
> > Hi everybody,
> > 
> > Since 2.6.18-rc1, up to and including -rc3, cpufreq has died on me. It
> > worked fine in 2.6.16.9.
> > 
> > # modprobe p4_clockmod
> > FATAL: Error inserting p4_clockmod
> > (/lib/modules/2.6.18-rc3/kernel/arch/i386/kernel/cpu/cpufreq/p4-clockmod.ko):
> > Device or resource busy
> > 
> 
>   I have similar problem with cpufreq-nforce2 -- http://lkml.org/lkml/2006/7/7/234
>   I haven't do a git-bisect yet.

Could you fellows try it without;

CONFIG_X86_SPEEDSTEP_CENTRINO
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE
CONFIG_X86_SPEEDSTEP_ICH
CONFIG_X86_SPEEDSTEP_SMI
CONFIG_X86_ACPI_CPUFREQ

It may likely be a driver registration thing.

Thanks,
	Zwane

