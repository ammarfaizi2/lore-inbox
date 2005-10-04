Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVJDVug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVJDVug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVJDVug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:50:36 -0400
Received: from ns.tasking.nl ([195.193.207.2]:59330 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S964992AbVJDVuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:50:35 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <7484.4341a91e.3c3d8@altium.nl> <d88.4342f0f2.78c40@altium.nl>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: PowerNow! frequency scaling causes stalls
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <1bb0.4342f8e9.4e62@altium.nl>
Date: Tue, 04 Oct 2005 21:49:29 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dick.streefland@altium.nl (Dick Streefland) wrote:
| I found out that the pauses only occur when the X server is running,
| not when I work on the console, or remotely. I can easily reproduce
| the problem by playing an mp3 file in a console with mpg321, and then
| running burnK7 to force frequency scaling. Without X server running,
| everything works fine, but when the X server is running, the music
| skips on frequency changes. However, when I start the X server, but
| switch back to the console with CTRL-ALT-F1, there are no skips.

It's me again :-). I solved the problem by changing the X.org video
driver from "vesa" to "sis". So it looks like the vesa driver (or
frame buffer?) is doing something funky.

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

