Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbUK3Qyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbUK3Qyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUK3Qyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:54:44 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:44490 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262183AbUK3QxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:53:17 -0500
Date: Tue, 30 Nov 2004 09:52:41 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
In-Reply-To: <200411301124.18628.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.61.0411300951220.14514@montezuma.fsmlabs.com>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
 <200411292354.05995.gene.heskett@verizon.net> <41AC9121.8020001@cybsft.com>
 <200411301124.18628.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Gene Heskett wrote:

> On Tuesday 30 November 2004 10:26, K.R. Foley wrote:
> >
> >"<some process> is being piggy... Read missed before next interrupt"
> >
> >2) tvtime is probably running at a RT priority of 99. The IRQ
> > handler for the rtc defaults to 48-49 (I think). If you didn't
> > already do so, you should bump the priority up as in:
> >
> >chrt -f -p 99 `/sbin/pidof 'IRQ 8'`
> 
> [root@coyote root]# chrt -f -p 99 `/sbin/pidof 'IRQ 8'`
> bash: chrt: command not found
> 
> chrt is an unknown command here. WTH?  Basicly an FC2 system.

Install the package first (from an FC2 system)

zwane@r3000 ~ {0:1} rpm -qif `which chrt`
Name        : schedutils                   Relocations: (not relocatable)
Version     : 1.3.0                             Vendor: Red Hat, Inc.
Release     : 6                             Build Date: Tue 17 Feb 2004 
10:16:15 MST
Install Date: Tue 13 Jul 2004 11:13:52 MDT      Build Host: tweety.devel.redhat.com
Group       : Applications/System           Source RPM: schedutils-1.3.0-6.src.rpm
Size        : 39412                            License: GPL
Signature   : DSA/SHA1, Thu 06 May 2004 16:36:57 MDT, Key ID b44269d04f2a6fd2
Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
Summary     : Utilities for manipulating process scheduler attributes
Description : schedutils is a set of utilities for retrieving and 
manipulating process scheduler-related attributes, such as real-time 
parameters and CPU affinity.

This package includes the chrt and taskset utilities.

Install this package if you need to set or get scheduler-related 
attributes.
