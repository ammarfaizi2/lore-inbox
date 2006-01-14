Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161580AbWANFXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161580AbWANFXD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 00:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161594AbWANFXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 00:23:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47747 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161580AbWANFXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 00:23:02 -0500
Date: Sat, 14 Jan 2006 00:22:22 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, seelam@cs.utep.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Jens Axboe <axboe@suse.de>
Subject: Re: Fall back io scheduler for 2.6.15?
Message-ID: <20060114052222.GA6212@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Jens Axboe <axboe@suse.de>
References: <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk> <1114207837.7339.50.camel@localhost.localdomain> <1114659912.16933.5.camel@mindpipe> <1114715665.18996.29.camel@localhost.localdomain> <1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com> <20060110212551.411a766d.akpm@osdl.org> <1137007032.4395.24.camel@localhost.localdomain> <20060111114303.45540193.akpm@osdl.org> <1137201135.4353.81.camel@localhost.localdomain> <20060113174914.7907bf2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113174914.7907bf2c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 05:49:14PM -0800, Andrew Morton wrote:
 > Mingming Cao <cmm@us.ibm.com> wrote:
 > >
 > > On 2.6.14, the
 > > fall back io scheduler (if the chosen io scheduler is not found) is set
 > > to the default io scheduler (anticipatory, in this case), but since
 > > 2.6.15-rc1, this semanistic is changed to fall back to noop.
 > 
 > OK.  And I assume that AS wasn't compiled, so that's why it fell back?
 > 
 > I actually thought that elevator= got removed, now we have
 > /sys/block/sda/queue/scheduler.  But I guess that's not very useful with
 > CONFIG_SYSFS=n.

It's also a lifesaver if the default scheduler happens to trigger some breakage
preventing boot, and you can tell users to workaround it with a bootparam
until the real problem is fixed (which has bitten us twice now, as Fedora
like several other distros chooses CFQ by default).

		Dave

