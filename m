Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbREUQgR>; Mon, 21 May 2001 12:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbREUQgG>; Mon, 21 May 2001 12:36:06 -0400
Received: from deckard.concept-micro.com ([62.161.229.193]:10274 "EHLO
	deckard.concept-micro.com") by vger.kernel.org with ESMTP
	id <S261418AbREUQf5>; Mon, 21 May 2001 12:35:57 -0400
Message-ID: <XFMail.20010521183553.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Mon, 21 May 2001 18:35:53 +0200 (CEST)
X-Face: #eTSL0BRng*(!i1R^[)oey6`SJHR{3Sf4dc;"=af8%%;d"%\#"Hh0#lYfJBcm28zu3r^/H^
 d6!9/eElH'p0'*,L3jz_UHGw"+[c1~ceJxAr(^+{(}|DTZ"],r[jSnwQz$/K&@MT^?J#p"n[J>^O[\
 "%*lo](u?0p=T:P9g(ta[hH@uvv
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: linux-kernel@vger.kernel.org
Subject: tmpfs + sendfile bug ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




        Hi all,

I just found a problem GETting a file stored in tmpfs using proftpd; I always
get a "426 Transfer aborted. Data connection closed."

That could be a bug with tmpfs and sendfile in 2.4.5-pre4 :

[...]
read(8, "%PDF-1.4\r%\342\343\317\323\r\n870 0 obj\r<< \r/L"..., 8192) = 8192
shmat(11, 0x4cfe65, 0x3)                = 0xbffff4d4
sendfile(11, 8, [0], 5045861)           = -1 EINVAL (Invalid argument)
[...]

Any idea ?

Best regards,
Pierre.



-- 
We are the dot in 0.2 Kb/s
