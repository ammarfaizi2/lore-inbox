Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTIQQUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTIQQUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:20:06 -0400
Received: from nebula.skynet.be ([195.238.2.112]:25778 "EHLO nebula.skynet.be")
	by vger.kernel.org with ESMTP id S262109AbTIQQUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:20:02 -0400
Date: Tue, 23 Oct 2001 15:34:00 +0200 (CEST)
From: jarausch@belgacom.net
Reply-To: jarausch@belgacom.net
Subject: Thanks - Nvidia modules with 2.4.13-pre6
To: rob <rob@dsvr.net>
Cc: Josh McKinney <forming@home.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Message-Id: <20030917161952.47915BC016@numa.skynet.be>
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


