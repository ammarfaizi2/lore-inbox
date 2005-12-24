Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVLXPjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVLXPjV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 10:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVLXPjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 10:39:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51091 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751242AbVLXPjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 10:39:20 -0500
Date: Sat, 24 Dec 2005 16:38:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, venkatesh.pallipadi@intel.com
Subject: Re: [patch 01/19] ACPI: Add support for FADT P_LVL2_UP flag
Message-ID: <20051224153852.GA26740@elf.ucw.cz>
References: <20051223221200.342826000@press.kroah.org> <20051223224737.GA19057@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223224737.GA19057@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> [ACPI] Add support for FADT P_LVL2_UP flag
> which tells us if C2 is valid for UP-only, or SMP.
> 
> As there is no separate bit for C3,  use P_LVL2_UP
> bit to cover both C2 and C3.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5165
> 
> (cherry picked from 28b86b368af3944eb383078fc5797caf2dc8ce44 commit)
> 
> Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Why is it covered by #ifdef HOTPLUG_CPU? This can bite on normal
CONFIG_SMP system, too, no?

-- 
Thanks, Sharp!
