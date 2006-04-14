Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWDNVgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWDNVgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWDNVgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:36:43 -0400
Received: from cpe-66-24-229-232.stny.res.rr.com ([66.24.229.232]:38328 "EHLO
	stargate.lab.yourst.com") by vger.kernel.org with ESMTP
	id S1751428AbWDNVgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:36:42 -0400
From: "Matt T. Yourst" <yourst@yourst.com>
To: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: i386 - msr support for xen
Date: Fri, 14 Apr 2006 17:36:34 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141736.34352.yourst@yourst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bastian Blank wrote:
> Hi folks
>
>The speedstep modules uses MSR to do its work. XEN can't allow this and
>the calls needs to be done via a hypercall into xen.
>
>I only found a hacky patch in
>http://article.gmane.org/gmane.comp.emulators.xen.devel/22282, which
>converts one of the speedstep modules to use xen. Does someone know if
>there is another solution raising?
>

I submitted a better patch to xen-devel that removes the need to modify any 
cpufreq modules - it directly traps the MSR writes and updates Xen's internal 
timers, something the patch above did not do correctly.

Please ignore the previous patch and update to the latest devel version of 
Xen, which should be incorporating the updated code in the next few days.

- Matt Yourst

-------------------------------------------------------
 Matt T. Yourst               yourst@cs.binghamton.edu
 Binghamton University, Department of Computer Science
-------------------------------------------------------
