Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVDBINk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVDBINk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 03:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDBINk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 03:13:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:20888 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261207AbVDBINh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 03:13:37 -0500
Subject: RE: x86 TSC time warp puzzle
From: Lee Revell <rlrevell@joe-job.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Jonathan Lundell <linux@lundell-bros.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6004629635@scsmsx403.amr.corp.intel.com>
References: <88056F38E9E48644A0F562A38C64FB6004629635@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 03:13:36 -0500
Message-Id: <1112429616.24111.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 23:05 -0800, Pallipadi, Venkatesh wrote:
> It can be SMI happening in the platform. Typically BIOS uses some SMI
> polling 
> to handle some devices during early boot. Though 500 microseconds sounds
> a 
> bit too high.
> 

Nope, that sounds just about right.  Buggy BIOSes that implement ACPI
via SMM (or so I have been told) can stall the machine for over a
millisecond, this is why some laptops lose timer ticks at HZ=1000.  The
issue is well known by Linux audio users, as it causes big problems for
people who buy laptops for live audio use.

A list of known good/bad machines would be a tremendous help, but no one
knows the exact extent of the problem.  All Acer laptops seem to be
affected.

Hardware manufacturers (laptops anyway) don't seem to care about
anything below 1-2ms because Windows uses HZ=100 and the ASIO drivers on
that platform only go down to about ~1.5 ms latency.

Lee



