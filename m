Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVAMPyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVAMPyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVAMPmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:42:04 -0500
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:42125 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S261680AbVAMPk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:40:59 -0500
Date: Tue, 23 Oct 2001 15:34:00 +0200 (CEST)
From: jarausch@belgacom.net
Subject: Thanks - Nvidia modules with 2.4.13-pre6
To: rob <rob@dsvr.net>
Cc: Josh McKinney <forming@home.com>, linux-kernel@vger.kernel.org
Reply-to: jarausch@belgacom.net
Message-id: <20050113151051.311F8FEC0F@numa-i.igpm.rwth-aachen.de>
MIME-version: 1.0
Content-type: TEXT/PLAIN; CHARSET=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Oct, rob wrote:
...
> Have you changed C compiler since your last kernel upgrade ?
...
On 22 Oct, Josh McKinney wrote:
> I have seen this same problem here before.  I am *pretty sure* that
> the problem was I was building the kernel with gcc-3.0 and to build
> the nvidia modules I was using gcc-2.95.4.  You may want to check what
> the sim-link in /usr/bin/cc points to.  The nvidia kernel modules use
> cc, so make sure cc is a symlink to the same compiler that you used to
> build your currently running kernel.

That's exactly what happend.
Under /usr/local/bin/gcc I have gcc-3.0.2 (cvs) and I recently
made a symlink /usr/local/bin/cc to it.

While I put /usr/bin (where gcc-2.95.3 is installed) first in my path
when compiling the kernel, I didn't do so, when (re)making the
kernel modules from Nvidia. This worked fine since the only  cc
was /usr/bin/cc which pointed to /usr/bin/gcc .

I have (re)made Nvidia's module with gcc-2.95.3 and it runs fine
now with 2.4.13-pre6 .

Sorry for the noise.

Helmut.



