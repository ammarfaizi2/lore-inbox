Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266078AbUFDXOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbUFDXOz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266070AbUFDXOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:14:16 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:61113 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266043AbUFDXJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:09:56 -0400
Subject: Re: jff2 filesystem in vanilla
From: David Woodhouse <dwmw2@infradead.org>
To: Daniel Egger <de@axiros.com>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
In-Reply-To: <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com>
References: <200406041000.41147.cijoml@volny.cz>
	 <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com>
Content-Type: text/plain
Message-Id: <1086390590.4588.70.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 05 Jun 2004 00:09:50 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-04 at 11:02 +0200, Daniel Egger wrote:
> JFFS2 is included in the standard kernels IIRC, however I'd recommend
> using the CVS version from the official repository as there are huge
> improvements in there.

JFFS2 in the 2.4 kernel is an old stable branch.

The code in 2.6 and in CVS is much faster to mount, especially, and it
also supports NAND flash.

Linus' tree is updated periodically when I'm sufficiently happy with the
stability of the development tree in CVS, and when I have time to merge
it, test it and read through all the changes for sanity -- which often
involves redoing some of them. You should be OK using what's in the
kernel -- let me know if you have problems.

> To use it on a non-MTD[1] device you will need an emulation layer,
> the pseudo Block-MTD device. And you will need some additional partition
> using ext2/ext3/reiserfs/FAT containing the kernel for your Grub/LILO
> bootloader.

JFFS2 on blkmtd isn't ideal -- it's designed to work on real flash. But
it works. It could do with someone making it use the stuff we did for
NAND -- batching writes into 512-byte chunks etc. 

-- 
dwmw2


