Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbTHUVFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbTHUVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:05:19 -0400
Received: from holomorphy.com ([66.224.33.161]:2704 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262895AbTHUVFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:05:15 -0400
Date: Thu, 21 Aug 2003 14:04:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Message-ID: <20030821210449.GH4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308202013.51702.habanero@us.ibm.com> <1061437329.15363.92.camel@nighthawk> <200308210910.07722.habanero@us.ibm.com> <1061479688.19036.1699.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061479688.19036.1699.camel@nighthawk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 08:28:08AM -0700, Dave Hansen wrote:
> It looks like you booted 20 processors, successfully.  
> You have 5 "Geniune" cpus and 16 "Xeon" cpus.  Are you using plain
> summit, or generic arch support?

AFAICT the only way we can see that is if we kick the same ones twice.
Using max_cpus= the exact number of cpus you have or CONFIG_NR_CPUS=
the exact number of cpus you have will get testers able to boot until
it's fixed.

It shouldn't be too hard to find the faulty code; all 5 "Genuine"
entries are bogus and alias the entries we actually want (the Xeons).


-- wli
