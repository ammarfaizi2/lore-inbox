Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUJNSuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUJNSuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUJNSsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:48:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266839AbUJNSXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:23:36 -0400
Date: Thu, 14 Oct 2004 14:20:52 -0400
From: Dave Jones <davej@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041014182052.GA18321@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Howells <dhowells@redhat.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	"Rusty Russell (IBM)" <rusty@au1.ibm.com>,
	David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Joy Latten <latten@us.ibm.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097570159.5788.1089.camel@baythorne.infradead.org> <27277.1097702318@redhat.com> <16349.1097752!349@redhat.com> <17271.1097756056@redhat.com> <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com> <Pine.GSO.4.61.0410141617100.21062@waterleaf.sonytel.be> <Pine.LNX.4.53.0410141022180.1018@chaos.analogic.com> <Pine.LNX.4.53.0410141131190.7061@chaos.analogic.com> <20041014155030.GD26025@redhat.com> <Pine.LNX.4.61.0410141352590.8479@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410141352590.8479@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 01:57:50PM -0400, Richard B. Johnson wrote:
 > 
 > Attached. This difference in size might make one think that
 > there's more in the 2.6.8 basic compile, but most stuff is
 > strings that say "BLAW is not set", which us longer than
 > "BLAW=y" or "BLAW=m". In fact, about twice as long....

A cursory examination show that the two aren't even remotely
similar in a lot of cases.  Take the misc filesystems section
for example.. (edited for brevity)

2.4
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m

2.6

# Miscellaneous filesystems
#
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_NAND=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_CRAMFS=m
CONFIG_VXFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m

And you wonder why 2.6 is taking longer ?
There are many more cases like this in your configs..

Unless you're comparing apples to apples, this is
just nonsense.

		Dave

