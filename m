Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVCOSFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVCOSFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVCOSEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:04:01 -0500
Received: from alog0387.analogic.com ([208.224.222.163]:61407 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261724AbVCOSBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:01:45 -0500
Date: Tue, 15 Mar 2005 12:59:49 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Bogus buffer length check in linux-2.6.11  read()
Message-ID: <Pine.LNX.4.61.0503151257450.12264@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-596628190-1110909589=:12264"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-596628190-1110909589=:12264
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


The attached file shows that the kernel thinks it's doing
something helpful by checking the length of the input
buffer for a read(). It will return "Bad Address" until
the length is 1632 bytes.  Apparently the kernel thinks
1632 is a good length!

Did anybody consider the overhead necessary to do this
and the fact that the kernel has no way of knowing if
the pointer to the buffer is valid until it actually
does the write. What was wrong with copy_to_user()?
Why is there the additional bogus check?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-596628190-1110909589=:12264
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="xxx.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0503151259490.12264@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="xxx.c"

DQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNp
bmNsdWRlIDx1bmlzdGQuaD4NCg0KaW50IG1haW4oKQ0Kew0KICAgICBjaGFy
IGJ1ZlsweDEwMF07DQogICAgIHNpemVfdCBpOw0KICAgICBpbnQgdmFsOw0K
ICAgICBmb3IoaT0weDEwMDA7IGkgPiAwOyBpLS0pDQogICAgIHsNCiAgICAg
ICAgIGlmKCh2YWwgPSByZWFkKFNURElOX0ZJTEVOTywgYnVmLCBpKSkgPT0g
LTEpDQogICAgICAgICAgICAgcGVycm9yKCJyZWFkIik7DQogICAgICAgICBl
bHNlDQogICAgICAgICB7DQogICAgICAgICAgICAgcHJpbnRmKCJBcHBhcmVu
dGx5IHRoZSBrZXJuZWwgdGhpbmtzICV1IGlzIGEgZ29vZCBsZW5ndGghXG4i
LCBpKTsNCiAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgIH0NCiAgICAg
fQ0KICAgIHJldHVybiAwOw0KfQ0K

--1879706418-596628190-1110909589=:12264--
