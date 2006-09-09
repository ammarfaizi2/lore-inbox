Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWIIOkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWIIOkf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWIIOke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:40:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44704 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932224AbWIIOke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:40:34 -0400
Date: Sat, 9 Sep 2006 10:47:39 -0400
From: Dave Jones <davej@redhat.com>
To: Thiago Galesi <thiagogalesi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cpufreq not working in 2.6.18-rc6
Message-ID: <20060909144739.GS28592@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thiago Galesi <thiagogalesi@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <82ecf08e0609090722p1ded935dm794d569278d60122@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ecf08e0609090722p1ded935dm794d569278d60122@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 11:22:02AM -0300, Thiago Galesi wrote:
 > Hello
 > 
 > Cpufreq is not working for me in 2.6.18-rc6 (as it worked flawlessly
 > in 2.6.17.7 and earlier versions)
 > 
 > I cannot insmod powernow-k7, it only shows (in dmesg):
 > 
 > powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
 > 
 > But then insmod fails with EBUSY (or better: init_module(0x804b018,
 > 11352, "")       = -1 EBUSY (Device or resource busy))
 > 
 > I traced this to cpufreq_register_driver returning -0x16
 > 
 > I disabled APM for this kernel, previous kernel version had APM
 > enabled (AFAIK, shouldn't be relevant; ACPI is enabled)
 > 
 > I tried to enable APM only to discover it does not work to compile APM
 > as a module :/ (complains about default_idle and machine_real_restart
 > being "unknown symbols")
 > 
 > ...
 >
 > CONFIG_X86_POWERNOW_K7_ACPI=y
 > ..
 > CONFIG_ACPI_PROCESSOR=m

Does it start working again if you change ACPI_PROCESSOR=y ?

	Dave

