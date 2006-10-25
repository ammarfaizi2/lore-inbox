Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423366AbWJYMH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423366AbWJYMH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423367AbWJYMH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:07:56 -0400
Received: from ns2.tasking.nl ([195.193.207.10]:22099 "EHLO ns2.tasking.nl")
	by vger.kernel.org with ESMTP id S1423366AbWJYMHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:07:55 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <3d6d.453f3a0f.92d2c@altium.nl> <1161755164.22582.60.camel@localhost.localdomain> <3d6d.453f3a0f.92d2c@altium.nl> <Pine.LNX.4.61.0610251336580.23137@yvahk01.tjqt.qr>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: What about make mergeconfig ?
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <31ed.453f5399.96651@altium.nl>
Date: Wed, 25 Oct 2006 12:07:53 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
| >Can't you do that with just a sort command?
| >
| >  sort .config other.config > new.config
| 
| That does not work where .config and other.config have the same symbol 
| listed, kconfig will bark and use the first value encountered. Because I 
| do have exactly that problem with my patch series (changes some Ys to 
| Ms), I am in need of the following patch to Kconfig TDTRT.

Or you can use the following hack:

  (sort .config other.config; echo set) | sh | grep ^CONFIG_ > new.config

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

