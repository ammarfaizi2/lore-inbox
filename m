Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTLIVai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTLIVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:30:37 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27657 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262868AbTLIVaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:30:35 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: dialectical deprecation Re: cdrecord hangs my computer
Date: 9 Dec 2003 21:19:17 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br5e8l$nne$1@gatekeeper.tmr.com>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312070812080.2057@home.osdl.org> <1201390000.1070900656@[10.10.2.4]> <3FD4CF90.3000905@nishanet.com>
X-Trace: gatekeeper.tmr.com 1071004757 24302 192.168.12.62 (9 Dec 2003 21:19:17 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FD4CF90.3000905@nishanet.com>, Bob  <recbo@nishanet.com> wrote:

| Today I realize that it's not double deprecation, it's dialectical
| deprecation, for a user who gets caught between the deprecation
| of ide-scsi and cdrecord targbuslun "flat" naming and then the
| cdrecord error message when trying to use a full devpath. The
| user's head is volleyed back and forth as cdrecord maintains
| its "denial".
| 
| cdrecord whines about the full devpath in the first instance,
| will not work if I use 1,0,0 in both places, but seems to
| catch a clue about the devpath stub from the first instance
| in order to use its 1,0,0 nomenclature below that.
| 
| #/etc/default/cdrecord
| CDR_DEVICE=ATAPI:/dev/scsi/host1/bus0/target0/lun0/generic
| #ATAPI:1,0,0 won't work in CDR_DEVICE, but...
| yamaha=   ATAPI:1,0,0   -1      -1      ""
| 
| I'm scared(under-informed) to drop ide-scsi since
| I'm using 3ware and don't know if just scsi-generic
| would be enough for that hd controller(needs ide-scsi?
| 3ware's site doc is not easy to find).

First, I would think you want the device with ATAPI, not the generic. I
don't use that nomenclature so I may be misreading it. I have used plain
/dev/hdc and had it work.

Second, did you use -scanbus to see which three numbers cdrecord wants
with ide-scsi and try those? You don't want ATAPI in front of it, just
dev=1,0,0 or similar.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
