Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTKFTT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbTKFTT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:19:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35850 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263356AbTKFTTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:19:25 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: 6 Nov 2003 19:08:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <boe68a$f3g$1@gatekeeper.tmr.com>
References: <3FA69CDF.5070908@gmx.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de>
X-Trace: gatekeeper.tmr.com 1068145738 15472 192.168.12.62 (6 Nov 2003 19:08:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FA8CA87.2070201@gmx.de>,
Prakash K. Cheemplavam <prakashkc@gmx.de> wrote:

| Sorry, I wasn't precise: The data is on the disc, as my DVD-ROM restores 
| the full image (md5sum matches), but the CD-RW does not.

There is a problem with ide-scsi in 2.6, and rather than fix it someone
came up with a patch to cdrecord to allow that application to work
properly, and perhaps "better" in some way. Since the problem with
ide-scsi seems to still exist for other applications, you will probably
find you have to work around the problem, by using the -pad option of
cdrecord (thought that was standard now for TAO at least) or reading
using the ide-cd driver.

I don't remember what the issue was for using ZIP drives with ide-scsi,
other than that using the alternate driver didn't do something right.
That might be fixed, I just went back to 2.4 on my machine which needs
that.

The problem using ide tapes was that you needed ide-scsi to make 'mt'
work, there's no patch for that AFAIK, and tape operations work without
kernel errors, but the data read back didn't have the same md5 as the
data written out. My one IDE tape drive is on the same box as the ZIP,
both seem to work fine with ide-scsi under 2.4. I only use those devices
for exchange with a few clients, so spending time on the problem wasn't
and isn't justified.

Hope this helps you define your problem more clearly.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
