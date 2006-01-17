Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWAQUmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWAQUmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAQUmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:42:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22507 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932174AbWAQUma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:42:30 -0500
Date: Wed, 18 Jan 2006 07:42:23 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: xfs depends on exportfs
Message-ID: <20060118074223.A8500612@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.61.0601172112550.11929@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0601172112550.11929@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Tue, Jan 17, 2006 at 09:16:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 09:16:51PM +0100, Jan Engelhardt wrote:
> Hi,
> 
> I could not find a clue on the first try on why xfs needs exportfs.
> The Kconfig says "select EXPORTFS if CONFIG_NFSD!=n", but there are no 
> occurrences of CONFIG_NFS* or CONFIG_EXP* in any of the files in fs/xfs/.
> Did I miss something or this a superfluous line in Kconfig? Interestingly 
> tho, `modinfo xfs.ko` returns "exportfs", so I suppose it's somewhere, well 
> hidden. If so, where?

xfs_export.c, find_exported_dentry.

cheers.

-- 
Nathan
