Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbVLWXFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbVLWXFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 18:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbVLWXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 18:05:31 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:7619 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161108AbVLWXFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 18:05:30 -0500
Subject: Re: [patch 18/19] SCSI: fix transfer direction in scsi_lib and st
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-scsi@vger.kernel.org, stefanr@s5r6.in-berlin.de
In-Reply-To: <20051223224852.GR19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
	 <20051223224852.GR19057@kroah.com>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 17:05:25 -0600
Message-Id: <1135379125.3728.57.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 14:48 -0800, Greg Kroah-Hartman wrote:
> plain text document attachment
> (scsi-fix-transfer-direction-in-scsi_lib-and-st.patch)
> -stable review patch.  If anyone has any objections, please let us know.

Erm, on this diff, you're missing the function

scsi_setup_blk_pc_cmnd()

Unless these patches were split up strangely and it actually went
through in some other patch that wasn't sent to linux-scsi?

I'd just take the diffs out of the current kernel tree:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a8c730e85e80734412f4f73ab28496a0e8b04a7b
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c9526497cf03ee775c3a6f8ba62335735f98de7a

I think they'll apply straight to 2.6.13-stable.

James


