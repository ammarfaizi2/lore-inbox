Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbULUVPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbULUVPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbULUVPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:15:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261841AbULUVPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:15:43 -0500
Date: Tue, 21 Dec 2004 13:15:34 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Attila BODY <compi@freemail.hu>, zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB storage (pendrive) problems
Message-ID: <20041221131534.411e3553@lembas.zaitcev.lan>
In-Reply-To: <mailman.1103615580.2095.linux-kernel2news@redhat.com>
References: <1103579679.23963.14.camel@localhost>
	<200412202325.20064.andrew@walrond.org>
	<41C75E8B.1020200@osdl.org>
	<mailman.1103615580.2095.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004 09:35:03 +0200, Attila BODY <compi@freemail.hu> wrote:

> > >>If I copy more than few megabytes to the drive, the activity LED keeps
> > >>flashing forever. sync, umount keeps runing forever, normal reboot is
> > >>inpossible (alt+sysreq+b seems to work)
> > >>
> > >>Tested with usb 1.1 and 2.0 pendrives, behaviour is the same.

> Dec 21 08:58:52 smiley kernel: /dev/ub/a: p1

> The problem is reproducable with 2.6.9. [...]

> I left the 2.0 device here all night and it did not. To make it worse,
> it seems that the whole USB 2.0 system went down, there was no activity
> even if i reconnected the pen, had to reboot to be detected and powered
> on again (normal reboot was not an option again, so I had to use
> alt-sysrq-B).

Thanks for the note. Unfortunately, 2.6.9 apparently has problems with
its virtual memory and write throttling, so I'm sure a few people suffering
from it will jump on this thread. It's essential to split root causes.
Your case may be different from the original poster's, who apparently
had the same deal with both ub and usb-storage. First things first, did
you try to set CONFIG_BLK_DEV_UB to off? What happens if you do?

-- Pete
