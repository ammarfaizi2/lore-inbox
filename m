Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVKRO2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVKRO2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVKRO2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:28:47 -0500
Received: from ns.tasking.nl ([195.193.207.2]:2521 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S1750730AbVKRO2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:28:46 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <6880bed30511180459s66efa480y9a8c5f90b1bc73ac@mail.gmail.com> <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com> <6880bed30511180459s66efa480y9a8c5f90b1bc73ac@mail.gmail.com> <6880bed30511180501r1fd6edd1hc64258842b8b0567@mail.gmail.com>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: Does Linux has File Stream mapping support...?
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <3278.437de4ff.52ed7@altium.nl>
Date: Fri, 18 Nov 2005 14:28:15 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Westerbaan <bas.westerbaan@gmail.com> wrote:
| Or you could - more cleanly - do a replace through all your source
| files (with an editor or a tool) which replaces printf with log (or
| something similar) and implement that function with the code to write
| to the log file and to stdout.

Simpler, but somewhat uglier, is to define a macro in one of your
header files (to be included after <stdio.h>):

#define printf(fmt, ...) { printf(fmt, ## __VA_ARGS__); fprintf(log_fp, fmt, ## __VA_ARGS__); }

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

