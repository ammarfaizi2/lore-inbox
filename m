Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbTBYAeY>; Mon, 24 Feb 2003 19:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264834AbTBYAeX>; Mon, 24 Feb 2003 19:34:23 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:30706 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264830AbTBYAeW>; Mon, 24 Feb 2003 19:34:22 -0500
Date: Tue, 25 Feb 2003 01:41:26 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Pavel Machek <pavel@ucw.cz>, torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq: allow user to specify voltage
Message-ID: <20030225004126.GA2477@brodo.de>
References: <20030224225545.GA16991@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224225545.GA16991@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel, Hi Linus,

> Hi!
>
> This allows user to specify voltage manually. This gives me 40 extra
> minutes (1h50m -> 2h30m) on HP omnibook which appears to have broken
> bios tables. Please apply,
>
>								Pavel 


Please don't apply this patch -- for the following reasons:
- it only uses the deprecated, overloaded cpufreq proc_intf
- selecting the voltage within the policy (minimum and maximum frequency,
  mode of operation) is not where it should be done: you may want a
  different voltage at min-speed as at max-speed. So the frequency tables,
  or -even better- the amd-k7-specific table may be a better choice for
  this.
- selecting the voltage manually is something which is only valid for some
  very few drivers - so let's only export one sysfs file[*] for these
  drivers.

	Dominik

[*] sysfs is the _only_ recommended way to access cpufreq these days. 
