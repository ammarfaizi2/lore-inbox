Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTFFQtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTFFQtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:49:08 -0400
Received: from fubar.phlinux.com ([216.254.54.154]:23488 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP id S262023AbTFFQtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:49:07 -0400
Date: Fri, 6 Jun 2003 10:02:41 -0700 (PDT)
From: Matt C <wago@phlinux.com>
To: The Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Matt C <wago@phlinux.com>
Subject: 2.4 Kernel problems when using redhat's gcc-2.96-112
Message-ID: <Pine.LNX.4.44.0306060956230.28649-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All-

I don't know if this issue is really worth digging into, but it's an odd 
one, so I figured I'd post it:

I've been using RedHat's gcc-2.96-112 compiler, which is the most recent 
errata for RH7.2, to build my kernels. With all the recent kernels that 
I've built (every release from 2.4.20 to 2.4.21-rc7), the NFS client stack 
has been unstable. This comes in the form of either a hardlock or an oops 
under a specific load. Unfortunately, this load involves proprietary data, 
so we can't give it to the community to use. I haven't been able to crash 
the kernel using any synthetic load (fsx, bonnie++) so far.

I was able to fix this problem by reverting to redhat's gcc-2.96-98 
compiler, which I believe is the version that ships with RH7.2.

Hope this helps someone. I'm happy to answer any more questions pertaining 
to this.

-Matt

