Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWCBVDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWCBVDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWCBVDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:03:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:2202 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932534AbWCBVDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:03:35 -0500
X-Authenticated: #30760622
Subject: scheduler switch at runtime
From: Gunter Fritz <gunter_fritz@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: pwil3058@bigpond.net.au, Christian Ege <christian.ege@cybertux.de>,
       Christian Binkert <cbinkert@fh-konstanz.de>, dkling@fh-konstanz.de,
       mbucher@fh-konstanz.de, maechtel@fh-konstanz.de
Content-Type: text/plain; charset=utf-8
Date: Thu, 02 Mar 2006 22:41:37 +0100
Message-Id: <1141335697.4419.15.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

The "dynsched" project aims switching the CPU scheduler at runtime. Its
based upon the "plugsched" patch by Peter Williams
(http://cpuse.sourceforge.net/). Increments to plugsched especially
a kthread, wich switchs between different schedulers, in sched.c and a
proc user interface. 

Following scheduler implementations are currently supported:
* ingosched
* nicksched
* staircase

There are some missing functions like converting task_struct between the
schedulers. First tests by Christian Ege on kernel 2.6.13.5 and 2.6.13.4
were successful. The spa based schedulers (such as spa_no_frills, zaphod
etc) are not yet supported. I hope they will be finished soon, just as
SMP support.

There is an alpha patch available at project site -
https://sourceforge.net/projects/dynsched
 
Using the procfs you can switch between the linux standard scheduler
(ingosched), nicksched and staircase schedulers by simply issuing: 
echo "name_of_the_scheduler" > /proc/dynsched

The dynsched project started as a part of our computer science study at
the university of applied sciences Konstanz. I hope it doesn't end with
our graduation. Thanks to Prof. Dr. Michael Mächtel, Peter Williams, who
provided us with helpful informations. The following people are
currently working with me on the dynsched project: Christian Ege, Dieter
Kling, Christian Binkert and Mathias Bucher.

Gunter Fritz

