Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTJ1UZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 15:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTJ1UZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 15:25:30 -0500
Received: from ns.tasking.nl ([195.193.207.2]:26116 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S261732AbTJ1UZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 15:25:28 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <2fde.3f8836ec.6380d@altium.nl>
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: Re: 2.6.0-test7: change in color depth of /dev/video0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <3e05.3f9ed081.a3006@altium.nl>
Date: Tue, 28 Oct 2003 20:24:33 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spam@streefland.xs4all.nl (Dick Streefland) wrote:
| Since linux-2.6.0-test7, xawtv complains about a color depth mismatch,
| and gives me a black screen:
| 
| $ xawtv               
| This is xawtv-3.72, running on Linux/i686 (2.6.0-test7)
| WARNING: v4l and x11 disagree about the color depth
| WARNING: fbuf.depth=24, x11 depth=16
| WARNING: Is v4l-conf installed correctly?
| WARNING: overlay mode disabled
| 
| With linux-2.6.0-test6 and earlier kernel, xawtv used to work just fine.
| The output of v4l-conf has not changed:
| 
| $ v4l-conf
| v4l-conf: using X11 display :0.0
| dga: version 2.0
| mode: 1280x1024, depth=16, bpp=16, bpl=2560, base=0xe8041000
| /dev/video0 [v4l2]: ioctl VIDIOC_QUERYCAP: Invalid argument
| /dev/video0 [v4l]: configuration done

Upgrading v4l-conf from version 3.72 to 3.90 (from Debian unstable)
solved the problem for me:

$ v4l-conf
v4l-conf: using X11 display :0.0
dga: version 2.0
mode: 1280x1024, depth=16, bpp=16, bpl=2560, base=0xe8041000
/dev/video0 [v4l2]: configuration done

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

