Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUBJNeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 08:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265876AbUBJNeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 08:34:09 -0500
Received: from ns.tasking.nl ([195.193.207.2]:51207 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S265872AbUBJNeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 08:34:05 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk> <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net> <20040206113305.GF21151@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402060850380.30672@home.osdl.org> <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402061041190.30672@home.osdl.org>
From: spam@altium.nl (Dick Streefland)
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <2e79.4028dd7d.6ae8c@altium.nl>
Date: Tue, 10 Feb 2004 13:32:45 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
| On Fri, 6 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
| > 
| > Umm...  How about
| > 
| > static inline void BUG() __attribute__((noreturn));
| > 
| > static inline void BUG(void)
| > {
| > 	__asm__ ....
| > }
| 
| Did you try that? Last time I tried, gcc would complain every time it saw 
| the thing about "noreturn function does return".

So, make sure it won't return ;-)

static inline void BUG(void)
{
        __asm__ ("1: jmp 1b");
        BUG();
}

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

