Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTEUXZC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTEUXZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:25:02 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38286 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262366AbTEUXZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:25:01 -0400
Subject: Re: userspace irq  =?ISO-8859-1?Q?=20balancer=C2=A0?=
From: Keith Mannthey <kmannth@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, davem@redhat.com,
       habanero@us.ibm.com, haveblue@us.ibm.com, wli@holomorphy.com,
       arjanv@redhat.com, pbadari@us.ibm.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       gh@us.ibm.com, johnstul@us.ltcfwd.linux.ibm, jamesclv@us.ibm.com,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1053541725.16886.4711.camel@dyn9-47-17-180.beaverton.ibm.com>
References: <1053541725.16886.4711.camel@dyn9-47-17-180.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 May 2003 16:39:29 -0700
Message-Id: <1053560371.19335.4725.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can build masks of capable clusters easily, even for NUMAQ

  Only kinda.  Boxes with Hyperthreaded cpus have an odd ordering
scheme.  The BIOS is free to assign apicids at will to any cpu.  It is
not forced to any certain scheme.  On some hyperthreaded boxes the 2nd
cpu is on the same apicid cluster even thought the cpu numbers are far
apart. 
  This makes building meaningful apicid masks (more than one cpu) a bit
tricky.  For example a user would have to know that cpus 1,2,9,10 were
on the same cluster not (1,2,3,4) as you would expect. Since the bios
can do what it will it makes it hard to build masks of capable clusters
easily in all situations.

Keith  

