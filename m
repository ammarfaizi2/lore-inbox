Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTKJWRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTKJWRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:17:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16900 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264134AbTKJWRS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:17:18 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: 10 Nov 2003 22:06:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bop25l$759$1@gatekeeper.tmr.com>
References: <3FA69CDF.5070908@gmx.de> <3FAABFBF.3040300@gmx.de> <20031107210535.GA445@suse.de> <3FAE1BB7.5090203@gmx.de>
X-Trace: gatekeeper.tmr.com 1068502005 7337 192.168.12.62 (10 Nov 2003 22:06:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FAE1BB7.5090203@gmx.de>,
Prakash K. Cheemplavam <prakashkc@gmx.de> wrote:

| Yup, I verified it in windows. Same issue, so it is a hardware and not 
| software issue.

Would you humor me and get the isosize of the image from isoinfo, then
try to read the image with 
  "dd if=/dev/cdrom bs=2k count={ISOSIZE} of=copy.iso" 
and see if reading just the correct amount will in fact get the last
data? Note that this is another of those "sometimes works" things, your
firmware may really not allow you to avoid readahead, but I have several
drives (one CD one CD-R) which do work this way.

Curiosity only, but easier than doing md5sum on all the files after
mounting the CD.

I think the issue is pretty well defined, with no pad some drives can't
read to the end, and with pad a few drives will read the pad if you just
copy all the drive can read. And use of DAO vs TAO to record makes a
difference with some burners as well.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
