Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUCPXW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbUCPXUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:20:25 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:52326 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261812AbUCPXUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:20:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Tue, 16 Mar 2004 18:19:54 -0500
User-Agent: KMail/1.6.1
Cc: Karol Kozimor <sziwan@hell.org.pl>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
References: <20040316182257.GA2734@dreamland.darkstar.lan> <20040316194805.GC20014@picchio.gall.it> <20040316214239.GA28289@hell.org.pl>
In-Reply-To: <20040316214239.GA28289@hell.org.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403161819.55351.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 04:42 pm, Karol Kozimor wrote:
> Thus wrote Daniele Venzano:
> > > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > > CONFIG_X86_PM_TIMER=y and I noticed that /proc/cpuinfo doesn't get
> > > updated when I switch frequency (via sysfs, using powernow-k7). The is
> > > issue seems cosmetic only, CPU frequency changes (watching
> > > temperature/battery life).
> > I can confirm, I'm seeing the same behavior. Please note that the
> > bogomips count gets updated, it's only the frequency that doesn't
> > change.
> 
> Same here with a P4-M, follow-up to John and Dmitry.
> Best regards,
> 

PM timer does not install CPUFREQ handler which would scale cpu_khz to
give proper display. I might cook up something later tonight.

-- 
Dmitry
