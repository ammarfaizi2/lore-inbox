Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268887AbUHLXmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268887AbUHLXmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268880AbUHLXmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:42:46 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:9611 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268887AbUHLXlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:41:37 -0400
Date: Fri, 13 Aug 2004 00:39:50 +0100
From: Dave Jones <davej@redhat.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       zaitcev@redhat.com
Subject: Re: [patch] 2.6 -- add IOI Media Bay to SCSI quirk list
Message-ID: <20040812233950.GA26970@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Patrick Mansfield <patmans@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	James.Bottomley@SteelEye.com, zaitcev@redhat.com
References: <200408122137.i7CLbGU13688@ra.tuxdriver.com> <20040812225118.GA20904@beaverton.ibm.com> <411BF6A5.2030306@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411BF6A5.2030306@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 07:00:53PM -0400, John W. Linville wrote:
 > Patrick Mansfield wrote:
 > 
 > >We seem to be getting quite a few of these. In theory we could add a line
 > >like this for every multi-lun SCSI device.
 > Isn't that what the quirk list is for?
 > 
 > >Can you instead try booting with scsi_mod.max_luns=8 (or such) or build
 > >with SCSI_MULTI_LUN enabled?
 > 
 > That works for my box, but what about for others?  Like those who may 
 > have both a multi-lun device and a single-lun device that hangs on a 
 > non-zero lun?  What about the average luser who can't be bothered to 
 > hack-up his startup scripts or *gasp* rebuild his kernel?
 > 
 > It seems like the quirk list is there for a reason.  If we start 
 > rejecting certain devices, then what is the criteria for a device to 
 > actually make it on the list?

I hit the same problem when I tried to get James to merge around a half dozen
or so entries (thats since grown to almost double that).  One possibility
is to fix this in the USB storage layer. (Assume all USB SCSI devices are
capable of handling MULTI_LUN without problem).

I believe Pete Zaitcev was writing an alternative usb-storage driver
that did something along these lines, but I'm not sure of the details.

	Dave

