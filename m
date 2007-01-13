Return-Path: <linux-kernel-owner+w=401wt.eu-S1422789AbXAMXKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789AbXAMXKX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbXAMXKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:10:23 -0500
Received: from gw.goop.org ([64.81.55.164]:59870 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030297AbXAMXKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:22 -0500
Message-Id: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:39 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com
Subject: [patch 00/20] XEN-paravirt: Xen guest implementation for paravirt_ops interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements the Linux Xen guest in terms of the
paravirt-ops interface.  The features in implemented this patch series
are:
 * domU only
 * UP only (most code is SMP-safe, but there's no way to create a new vcpu)
 * writable pagetables, with late pinning/early unpinning
   (no shadow pagetable support)
 * supports both PAE and non-PAE modes
 * xen console
 * virtual block device (blockfront)

(Netfront needs a bit of updating, and will be in a separate patch later.)

The patch series is in two parts:

1-11: cleanups to the core kernel, either to fix outright problems,
      or to add appropriate hooks for Xen
12-20: the Xen guest implementation itself

I've tried to make each patch as self-explanatory as possible.  The
series is based on 2.6.20-rc4-mm1.

Thanks,
	J
-- 

