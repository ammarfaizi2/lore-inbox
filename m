Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTKVU2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 15:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTKVU2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 15:28:11 -0500
Received: from ns.tasking.nl ([195.193.207.2]:52486 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S262750AbTKVU2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 15:28:10 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <2535.3fbe9484.4f0e6@altium.nl> <2535.3fbe9484.4f0e6@altium.nl> <200311220001.47992.bzolnier@elka.pw.edu.pl> <3a59.3fbea202.a0099@altium.nl>
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: Re: IDE lockup after floppy access
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <ef6.3fbfc69c.7de5a@altium.nl>
Date: Sat, 22 Nov 2003 20:27:08 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spam@streefland.xs4all.nl (Dick Streefland) wrote:
| Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
| | Does disabling CONFIG_PREEMPT cure the problem?
| 
| No, I just tried without CONFIG_PREEMPT, but it still hangs.

I did some more tests (I'm becoming a big fan of the ext3 filesystem).
The lockup also occurs with older kernels like 2.6.0-test1 and 2.4.20.
A sure way to reproduce the problem is running the following one-liner
with a DOS floppy in the drive:

  find / & mdir

Disabling DMA with "hdparm -d0" doesn't help, although the kernel
messages are different. I now get:

  hda: lost interrupt

What could be the cause for this. Is my hardware dying? And if yes,
what part? Any tips on how to isolate this problem? I know for sure
that my floppy worked two months ago, but I don't known when it worked
for the last time.

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

