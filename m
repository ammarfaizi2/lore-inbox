Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272223AbTHNGlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272225AbTHNGlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 02:41:19 -0400
Received: from mail.gondor.com ([212.117.64.182]:3599 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S272223AbTHNGlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 02:41:18 -0400
Date: Thu, 14 Aug 2003 08:37:12 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030814063712.GA3044@gondor.com>
References: <20030806150335.GA5430@gondor.com> <200308130221.26305.bzolnier@elka.pw.edu.pl> <20030813223641.GA1921@gondor.com> <200308140114.32027.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308140114.32027.bzolnier@elka.pw.edu.pl>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 01:14:32AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Thanks!  Can you do some more testing?

Ok, after I compiled the driver with special udma feature and special
fasttrak feature, I got decent transfer rates (40-50MB/s) from the
drive.

I let a process running which continously copied a big (700MB) file,
removed the old copy, umounted an mounted the filesystem, and checked
the md5sum of the file. I didn't see a single corruption in >160 copies. 

At the same time, a second process was generating load by compiling
kernels on a different partition on the same drive. One partition was
below the 137GB boundary, one was above it.

> I will remove these offending lines from 2.6.x if there are no problems.

These tests were done with patched 2.4.21.

Jan

