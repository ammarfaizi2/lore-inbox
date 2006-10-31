Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423679AbWJaREj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423679AbWJaREj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423682AbWJaREj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:04:39 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:9897 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423679AbWJaREi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:04:38 -0500
Subject: Re: [ckrm-tech] RFC: Memory Controller
From: Dave Hansen <haveblue@us.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: balbir@in.ibm.com, vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       pj@sgi.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com, menage@google.com
In-Reply-To: <45470DF4.70405@openvz.org>
References: <20061030103356.GA16833@in.ibm.com>
	 <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org>
	 <454638D2.7050306@in.ibm.com>  <45470DF4.70405@openvz.org>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 09:04:08 -0800
Message-Id: <1162314249.28876.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 11:48 +0300, Pavel Emelianov wrote:
> If memory is considered to be unreclaimable then actions should be
> taken at mmap() time, not later! Rejecting mmap() is the only way to
> limit user in unreclaimable memory consumption.

I don't think this is necessarily true.  Today, if a kernel exceeds its
allocation limits (runs out of memory) it gets killed.  Doing the
limiting at mmap() time instead of fault time will keep a sparse memory
applications from even being able to run.

Now, failing an mmap() is a wee bit more graceful than a SIGBUS, but it
certainly introduces its own set of problems.

-- Dave

