Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbTEITvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbTEITvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:51:44 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:41875 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S261617AbTEITvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:51:43 -0400
Subject: ext3/lilo/2.5.6[89] (was: [KEXEC][2.5.69] kexec for 2.5.69
	available)
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Cc: Andy Pfiffer <andyp@osdl.org>
In-Reply-To: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3.99 (Preview Release)
Date: 09 May 2003 22:04:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2003-05-09 um 21.04 schrieb Andy Pfiffer:

> [...]
>  I had an unrelated
> delay in posting this due to some strange behavior of late with LILO and
> my ext3-mounted /boot partition (/sbin/lilo would say that it updated,
> but a subsequent reboot would not include my new kernel)

So I'm not the only one having this problem... I think I first saw this
with 2.5.68 but I'm not sure.

My boot partition is a small ext3 partition on a lvm2 volume accessed
over device-mapper (I've written a lilo patch for that, but the patch is
working and) but I don't think that has something to do with the
problem.

When syncing, unmounting and waiting some time after running lilo, the
changes sometimes seem correctly written to disk, I don't know when
exactly.

Could it be that the location of /boot/map is not written to the
partition sector of /dev/hda? Or not flushed correctly or something?

After reboot the old kernel came up again (though it was moved to
vmlinuz.old).

-- 
Christophe Saout <christophe@saout.de>

