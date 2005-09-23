Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVIWSKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVIWSKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVIWSKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:10:49 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:9856 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750976AbVIWSKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:10:47 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 23 Sep 2005 11:13:30 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] sys_epoll_wait() timeout saga ...
Message-ID: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1932119442-1127499048=:10222"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1932119442-1127499048=:10222
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed


The sys_epoll_wait() function was not handling correctly negative timeouts 
(besides -1), and like sys_poll(), was comparing millisec to secs in 
testing the upper timeout limit.


Signed-off-by: Davide Libenzi <davidel@xmailserver.org>


- Davide

--8323328-1932119442-1127499048=:10222
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=epoll-timeofix-2.diff
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=epoll-timeofix-2.diff

LS0tIGEvZnMvZXZlbnRwb2xsLmMJMjAwNS0wOS0yMyAxMDo1Njo1Ny4wMDAw
MDAwMDAgLTA3MDANCisrKyBiL2ZzL2V2ZW50cG9sbC5jCTIwMDUtMDktMjMg
MTE6MDA6MDYuMDAwMDAwMDAwIC0wNzAwDQpAQCAtMTUwNyw3ICsxNTA3LDcg
QEANCiAJICogYW5kIHRoZSBvdmVyZmxvdyBjb25kaXRpb24uIFRoZSBwYXNz
ZWQgdGltZW91dCBpcyBpbiBtaWxsaXNlY29uZHMsDQogCSAqIHRoYXQgd2h5
ICh0ICogSFopIC8gMTAwMC4NCiAJICovDQotCWp0aW1lb3V0ID0gdGltZW91
dCA9PSAtMSB8fCB0aW1lb3V0ID4gKE1BWF9TQ0hFRFVMRV9USU1FT1VUIC0g
MTAwMCkgLyBIWiA/DQorCWp0aW1lb3V0ID0gdGltZW91dCA8IDAgfHwgKHRp
bWVvdXQgLyAxMDAwKSA+PSAoTUFYX1NDSEVEVUxFX1RJTUVPVVQgLyBIWikg
Pw0KIAkJTUFYX1NDSEVEVUxFX1RJTUVPVVQ6ICh0aW1lb3V0ICogSFogKyA5
OTkpIC8gMTAwMDsNCiANCiByZXRyeToNCg==

--8323328-1932119442-1127499048=:10222--
