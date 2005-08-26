Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbVHZO1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbVHZO1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbVHZO1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:27:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34231 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751587AbVHZO1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:27:02 -0400
Date: Fri, 26 Aug 2005 05:30:51 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: serue@us.ibm.com, Chris Wright <chrisw@osdl.org>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>
Subject: Re: [PATCH 0/5] LSM hook updates
Message-ID: <20050826103051.GA1815@sergelap.austin.ibm.com>
References: <20050825012028.720597000@localhost.localdomain> <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode> <20050825053208.GS7762@shell0.pdx.osdl.net> <20050825191548.GY7762@shell0.pdx.osdl.net> <20050826092306.GA429@sergelap.austin.ibm.com> <1125062879.5812.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125062879.5812.67.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> On Fri, 2005-08-26 at 04:23 -0500, serue@us.ibm.com wrote:
> > Here are some numbers on a 4way x86 - PIII 700Mhz with 1G memory (hmm,
> > highmem not enabled).  I should hopefully have a 2way ppc available
> > later today for a pair of runs.
> > 
> > dbench and tbench were run 50 times each, kernbench and reaim 10 times
> > each.  Results are mean +/- 95% confidence half-interval.  Kernel had
> > selinux and capabilities compiled in.
> > 
> > A little surprising: kernbench is improved, but dbench and tbench
> > are worse - though within the 95% CI.
> 
> Might be interesting to roll in Chris' patch (sent separately to lsm and
> selinux list) for "remove selinux stacked ops" in place of your patch,
> as that will avoid the indirect call through the secondary_ops in
> SELinux.  At that point, you can also disable the capability module
> altogether, as SELinux will just directly use the built-in cap_
> functions from commoncap.

True - I'll start a new set of jobs and hopefully report back sunday or
monday.

thanks,
-serge
