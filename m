Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUHTHPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUHTHPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHTHPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:15:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:64141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267597AbUHTHNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:13:45 -0400
Date: Fri, 20 Aug 2004 00:11:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, nickpiggin@yahoo.com.au
Subject: Re: Possible dcache BUG
Message-Id: <20040820001154.0a5cf331.akpm@osdl.org>
In-Reply-To: <20040820000238.55e22081@laptop.delusion.de>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	<20040820000238.55e22081@laptop.delusion.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" <us15@os.inf.tu-dresden.de> wrote:
>
> I've tried to download 700 MB of data from a digital camera via USB using
>  "gphoto2 --get-all-files" and I can repeatedly run my 128 MB box out of
>  memory using either Linux 2.4.26 or 2.6.8.1 for that.

whee.  How much swap is online?

Not that it matters - you seem to have a bunch of reclaimable pagecache
just sitting there.  Very odd.

Could gphoto2 be using mlock?  Does it run as root?
