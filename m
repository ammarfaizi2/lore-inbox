Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUG0TXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUG0TXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUG0TXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:23:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266204AbUG0TX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:23:29 -0400
Date: Tue, 27 Jul 2004 20:23:28 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Message-ID: <20040727192328.GF12308@parcelfarce.linux.theplanet.co.uk>
References: <200407271233.04205.gene.heskett@verizon.net> <200407271402.59846.gene.heskett@verizon.net> <20040727105039.052352d8.rddunlap@osdl.org> <200407271442.33208.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407271442.33208.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 02:42:33PM -0400, Gene Heskett wrote:
> Humm, I just tried to build it using 2.6.8-rc1 as the main patch to 
> 2.6.7, but then the 2.6.8-rc2-bk3 patch will not apply as the second 
> patch...  I'll go back and redo the rc2 patch first.  Or do I really 
> have something totally fubared?

It goes like that:
2.6.7
2.6.7 + 7-bk<n>
2.6.7 + 8-rc1
2.6.7 + 8-rc1 + 8-rc1-bk<n>
2.6.7 + 8-rc2
2.6.7 + 8-rc2 + 8-rc2-bk<n>
...

Since rc1 works and rc2 doesnt, you want 
	linux-2.6.7.tar.bz2 +
	testing/patch-2.6.8-rc1.bz2 +
	snapshots/old/patch-2.6.8-rc1-bk<n>.bz2
(all under /pub/linux/kernel/v2.6 on ftp.kernel.org and mirrors)
