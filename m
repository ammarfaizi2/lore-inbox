Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVJaTpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVJaTpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVJaTpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:45:13 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:4281 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932427AbVJaTpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:45:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Date: Mon, 31 Oct 2005 20:45:32 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>
References: <200510311606.36615.rjw@sisk.pl> <20051031113413.34a599cd.akpm@osdl.org>
In-Reply-To: <20051031113413.34a599cd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510312045.32908.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 31 of October 2005 20:34, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
}-- snip --{
> > scheduling while atomic: swapper/0x00000001/1
> > 
> > Call Trace:<ffffffff8035014a>{schedule+122} <ffffffff802e2453>{cpufreq_frequency_table_target+371}
> >        <ffffffff8011d60c>{powernowk8_target+1916} <ffffffff802dfdb4>{__cpufreq_driver_target+116}
> >        <ffffffff801be269>{sysfs_new_dirent+41} <ffffffff802e097e>{cpufreq_governor_performance+62}
> >        <ffffffff802dec8d>{__cpufreq_governor+173} <ffffffff802df417>{__cpufreq_set_policy+551}
> >        <ffffffff802df5bf>{cpufreq_set_policy+79} <ffffffff802df946>{cpufreq_add_dev+806}
> >        <ffffffff802df540>{handle_update+0} <ffffffff802ae21a>{sysdev_driver_register+170}
> >        <ffffffff802df106>{cpufreq_register_driver+198} <ffffffff8010c122>{init+194}
> >        <ffffffff8010f556>{child_rip+8} <ffffffff8010c060>{init+0}
> >        <ffffffff8010f54e>{child_rip+0} 
> 
> Well I can't find it.  Ingo, didn't you have a debug patch which would help
> us identify where this atomic section started?

This is 100% reproducible on my box so I'll try to figure out what's up tomorrow
(unless someone else does it earlier ;-)).  Now I can only say it did not happen
with 2.6.14-rc5-mm1.

> > Additionally there are some problems with freezing processes by swsusp.

Once the box has not suspended due to a process refusing to freeze, but I was
unable to trace the problem at that time.  This does not seem to be readily
reproducible, however.

Greetings,
Rafael
