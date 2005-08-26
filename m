Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVHZNa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVHZNa2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 09:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbVHZNa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 09:30:28 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:42476 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750998AbVHZNa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 09:30:27 -0400
Subject: Re: [PATCH 0/5] LSM hook updates
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: serue@us.ibm.com
Cc: Chris Wright <chrisw@osdl.org>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>
In-Reply-To: <20050826092306.GA429@sergelap.austin.ibm.com>
References: <20050825012028.720597000@localhost.localdomain>
	 <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode>
	 <20050825053208.GS7762@shell0.pdx.osdl.net>
	 <20050825191548.GY7762@shell0.pdx.osdl.net>
	 <20050826092306.GA429@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 26 Aug 2005 09:27:59 -0400
Message-Id: <1125062879.5812.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 04:23 -0500, serue@us.ibm.com wrote:
> Here are some numbers on a 4way x86 - PIII 700Mhz with 1G memory (hmm,
> highmem not enabled).  I should hopefully have a 2way ppc available
> later today for a pair of runs.
> 
> dbench and tbench were run 50 times each, kernbench and reaim 10 times
> each.  Results are mean +/- 95% confidence half-interval.  Kernel had
> selinux and capabilities compiled in.
> 
> A little surprising: kernbench is improved, but dbench and tbench
> are worse - though within the 95% CI.

Might be interesting to roll in Chris' patch (sent separately to lsm and
selinux list) for "remove selinux stacked ops" in place of your patch,
as that will avoid the indirect call through the secondary_ops in
SELinux.  At that point, you can also disable the capability module
altogether, as SELinux will just directly use the built-in cap_
functions from commoncap.

-- 
Stephen Smalley
National Security Agency

