Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTJUUyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbTJUUyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:54:33 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20996 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263358AbTJUUya
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:54:30 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: ATA Defect management
Date: 21 Oct 2003 20:44:29 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn45rd$is6$1@gatekeeper.tmr.com>
References: <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60> <200310171037.h9HAbOrv000559@81-2-122-30.bradfords.org.uk>
X-Trace: gatekeeper.tmr.com 1066769069 19334 192.168.12.62 (21 Oct 2003 20:44:29 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310171037.h9HAbOrv000559@81-2-122-30.bradfords.org.uk>,
John Bradford  <john@grabjohn.com> wrote:
| [Note to Eric, who is CC'ed, can you comment on how Maxtor drives
| handle these issues?]
| 
| Quote from "Norman Diamond" <ndiamond@wta.att.ne.jp>:
| > Friends in the disk drive section at Toshiba said this:
| > 
| > When a drive tries to read a block, if it detects errors, it retries up to
| > 255 times.  If a retry succeeds then the block gets reallocated.  IF 255
| > RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
| 
| OK, this is interesting, at least we have some specific information.
| 
| > This was so unbelievable to that I had to confirm this with them in
| > different words.  In case of a temporary error, the drive provides the
| > recovered data as the result of the read operation and the drive writes the
| > data to a reallocated sector.  In case of a permanent error, the block is
| > assumed bad, and of course the data are lost.  Since the data are assumed
| > lost, the drive keeps the defective LBA sector number associated with the
| > same defective physical block and it does not reallocate the defective
| > block.

Not so. Assuming the admin is restoring to the same bad drive (the
twit!), since the drive does do relocate on write, the recovery will
work, the data will be whole, and life will be good.

I'm not sure why one would do a by-sector backup, but I guess for some
filesystems or raw database info it might be useful.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
