Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUEZUvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUEZUvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUEZUvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:51:05 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:32991 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265795AbUEZUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:51:00 -0400
Date: Wed, 26 May 2004 16:52:06 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, zwane@linuxpower.ca
Subject: RE: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
In-Reply-To: <7F740D512C7C1046AB53446D372001730182B346@scsmsx402.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0405261641510.1794@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D372001730182B346@scsmsx402.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Nakajima, Jun wrote:

> >Anyone have any idea why this is happening?
> >
> Does this happen when you run the kernel on top of VMWare, as far as I
> understand? If so, it is likely that VMWare is not simulating the
> behavior of cpuid regarding HT support (especially, mapping between
> logical and processor package). Then, you should get the same result
> even when you run 2.6.6 kernel. Do you have dmesg output from some older
> kernel or 2.6.6?

It's a vmware thing as far as i know, it just runs the cpuid from the host
and will therefore report what it finds there, but then the kernel gets
confused when it finds that it really doesn't have a sibling processor.
The crash on boot is just a side effect of the new sched domains code
which depends more on this information.
