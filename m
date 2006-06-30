Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWF3Q7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWF3Q7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWF3Q7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:59:32 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:62861 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751627AbWF3Q7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:59:32 -0400
Date: Fri, 30 Jun 2006 12:59:29 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
In-reply-to: <20060630015251.e6a4e526.zaitcev@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Message-id: <1151686769.3285.465.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org>
	<20060630015251.e6a4e526.zaitcev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 01:52 -0700, Pete Zaitcev wrote:

> The idea to allocate a URB for every little user write bothers me as
> well. It was a dirty code thrown together quickly by someone who could
> not be bothered to use a circular buffer and two URBs. It was fine
> for the visor.c, but the Airprime is a higher performance card, and it
> can be used in a home gateway with a low-power CPU. I'm not happy.

I agree completely. I was already planning to work on improving the
write path at some point.
The read path is more important though, these networks are asymmetric -
Sierra Wireless specifies max 2.4Mbps download vs 153Kbps upload for the
EM5625 and MC5720, presumably the other devices are similar. So this
patch was focused on getting the best read performance.

> 
> -- Pete

