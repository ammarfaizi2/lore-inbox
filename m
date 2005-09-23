Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVIWRev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVIWRev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVIWRev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:34:51 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:17902 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751116AbVIWReu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:34:50 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 23 Sep 2005 10:37:36 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] Make epoll_wait() handle negative timeouts as MAX_SCHEDULE_TIMEOUT
 ...
Message-ID: <Pine.LNX.4.63.0509231031570.10222@localhost.localdomain>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1950461079-1127496933=:10222"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1950461079-1127496933=:10222
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed


As reported by Vadim Lobanov, epoll_wait() did not handle correctly 
timeouts <0 (only the -1 case was MAX_SCHEDULE_TIMEOUT'd).


Signed-off-by: Davide Libenzi <davidel@xmailserver.org>


- Davide

--8323328-1950461079-1127496933=:10222
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=epoll-timeofix.diff
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=epoll-timeofix.diff

LS0tIGEvZnMvZXZlbnRwb2xsLmMJMjAwNS0wOS0yMyAxMDowNjo0NS4wMDAw
MDAwMDAgLTA3MDANCisrKyBiL2ZzL2V2ZW50cG9sbC5jCTIwMDUtMDktMjMg
MTA6MDk6MzUuMDAwMDAwMDAwIC0wNzAwDQpAQCAtMTUwNyw3ICsxNTA3LDcg
QEANCiAJICogYW5kIHRoZSBvdmVyZmxvdyBjb25kaXRpb24uIFRoZSBwYXNz
ZWQgdGltZW91dCBpcyBpbiBtaWxsaXNlY29uZHMsDQogCSAqIHRoYXQgd2h5
ICh0ICogSFopIC8gMTAwMC4NCiAJICovDQotCWp0aW1lb3V0ID0gdGltZW91
dCA9PSAtMSB8fCB0aW1lb3V0ID4gKE1BWF9TQ0hFRFVMRV9USU1FT1VUIC0g
MTAwMCkgLyBIWiA/DQorCWp0aW1lb3V0ID0gdGltZW91dCA8IDAgfHwgdGlt
ZW91dCA+IChNQVhfU0NIRURVTEVfVElNRU9VVCAtIDEwMDApIC8gSFogPw0K
IAkJTUFYX1NDSEVEVUxFX1RJTUVPVVQ6ICh0aW1lb3V0ICogSFogKyA5OTkp
IC8gMTAwMDsNCiANCiByZXRyeToNCg==

--8323328-1950461079-1127496933=:10222--
