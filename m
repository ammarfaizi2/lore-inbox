Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271898AbTHDQbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271895AbTHDQbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:31:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36047 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S271892AbTHDQbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:31:05 -0400
Date: Mon, 4 Aug 2003 09:30:35 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Diffie <diffie@blazebox.homeip.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030804093035.A24860@beaverton.ibm.com>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org> <20030803015510.GB4696@blazebox.homeip.net> <20030802190737.3c41d4d8.akpm@osdl.org> <20030803214755.GA1010@blazebox.homeip.net> <20030803145211.29eb5e7c.akpm@osdl.org> <20030803222313.GA1090@blazebox.homeip.net> <20030803223115.GA1132@blazebox.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030803223115.GA1132@blazebox.homeip.net>; from diffie@blazebox.homeip.net on Sun, Aug 03, 2003 at 06:31:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 06:31:15PM -0400, Diffie wrote:
> On Sun, Aug 03, 2003 at 06:23:13PM -0400, Diffie wrote:

> > Thank you for all your help.Sorry but i gave the wrong URL in previous
> > email.The correct one is http://www.blazebox.homeip.net:81/diffie/images/linux-2.6.0-test2/ 
> > 

Per your screen dump - it found the cd-rom's on id 3 and 4, but not your
disk drive that was at id 0, and the adapter found something at id 6 (host
adapter is at id 7).

You could try turning on scan logging, it might give more information.
You can turn on the logging at boot time, make sure you have
CONFIG_SCSI_LOGGING on, the information of interest (scan of host 0 chan 0
id 0 lun 0) likely will scroll off screen.

For scan logging, add to your boot line:

	scsi_mod.scsi_logging_level=0x140

To limit the logging info, make sure max_scsi_luns=1 via config or boot
time option scsi_mod.max_scsi_luns=1.

-- Patrick Mansfield
