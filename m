Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266040AbUALDnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 22:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUALDnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 22:43:17 -0500
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:60172
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S266040AbUALDnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 22:43:16 -0500
Subject: CPUFreq and strange /proc/cpuinfo
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1073878908.4971.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 22:43:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently upgraded to kernel 2.6.1 (previously 2.6.0) and decided to
try using some of the dynamic cpufreq daemons such as cpufreqd and
powernowd.  Both of these seem to work, but there's a strange anomaly in
/proc/cpuinfo.  Normally my /proc/cpuinfo had entries like this (only
relavent entries):

model name      : Intel(R) Pentium(R) M processor 1700MHz
cpu MHz         : 1694.984
bogomips        : 3358.72

which looks pretty good I guess, however, once you enable either of
these two daemons these numbers get all confused, for example, when
scaled to full speed I get:

model name      : Intel(R) Pentium(R) M processor 1700MHz
cpu MHz         : 4802.454
bogomips        : 9516.37

and when scaled down to the lowest speed (600Mhz) I get something that
looks like this:

model name      : Intel(R) Pentium(R) M processor 1700MHz
cpu MHz         : 2824.973
bogomips        : 5597.86

I'm not sure if this is just a cosmetic blip or not (it does appear to
be), but I thought it was odd.  Any ideas what could cause this or
suggestions how to fix it?  Or maybe I should ignore it.

Scaling driver is "centrino".

Later,
Tom


