Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263774AbTKFRmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTKFRmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:42:44 -0500
Received: from mhub-c4.tc.umn.edu ([160.94.128.34]:30946 "EHLO
	mhub-c4.tc.umn.edu") by vger.kernel.org with ESMTP id S263774AbTKFRmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:42:43 -0500
X-Umn-Remote-Mta: [N] x84-95-9-dhcp.reshalls.umn.edu #+HF+LO
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
From: Matthew Reppert <repp0017@tc.umn.edu>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FAA5B3A.4090800@gmx.de>
References: <20031106130030.GC1145@suse.de>
	 <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de>
	 <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de>
	 <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de>
	 <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de>
	 <3FAA5397.6010702@gmx.de> <20031106135134.GA1194@suse.de>
	 <3FAA5B3A.4090800@gmx.de>
Content-Type: text/plain
Message-Id: <1068140559.359.5.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 11:42:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-06 at 08:31, Prakash K. Cheemplavam wrote:
> Jens Axboe wrote:
> > On Thu, Nov 06 2003, Prakash K. Cheemplavam wrote:
> > 
> >>#
> >># SCSI device support
> >>#
> >>CONFIG_SCSI=y
> > 
> > 
> > Need I say more?
> 
> But then it is a bug: In menuconfig nothing is activated or please tell 
> me how through the menu it is possible to set this to "no".

You have CONFIG_USB_STORAGE=y in your config; USB storage does a
"select SCSI", which means that if USB storage is active, it forces
CONFIG_SCSI=y. So, if you turn off USB storage, you can turn off SCSI.
Making USB storage a module won't help; select seems to always select
Y.

Matt

