Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUIGKgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUIGKgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267833AbUIGKgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:36:15 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:12202 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S267826AbUIGKf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:35:58 -0400
Date: Tue, 7 Sep 2004 13:35:52 +0300 (EEST)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: netdev@oss.sgi.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial fix for out of bounds array access in xfrm4_policy_check
Message-ID: <Pine.LNX.4.61.0409071322100.8637@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1646943047-1948299716-1094553352=:8637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1646943047-1948299716-1094553352=:8637
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello!

Coverity found a bug in accessing xfrm4_policy_check using XFRM_POLICY_FWD 
(=2) as index in sk->sk_policy.

sk->sk_policy[] is defined in sock.h as:

struct xfrm_policy *sk_policy[2];

Attached is the fix.

http://linuxbugs.coverity.com/external/editbugparent.php?viewbugid=2138&checkers%5B%5D=all&status%5B%5D=BUG&status%5B%5D=UNINSPECTED&status%5B%5D=UNKNOWN&status%5B%5D=DON%27T%20CARE&status%5B%5D=PENDING&product%5B%5D=all&component%5B%5D=all&file=&fn=&sortby=reverse_rank&before=&after=&curpage=2&bugid=-1&comment=&reason=

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
---1646943047-1948299716-1094553352=:8637
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="out-of-bounds-xfrm_policy.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0409071335520.8637@hosting.rdsbv.ro>
Content-Description: 
Content-Disposition: attachment; filename="out-of-bounds-xfrm_policy.patch"

LS0tIGxpbnV4L2luY2x1ZGUvbmV0L3NvY2suaAkyMDA0LTA5LTA3IDEzOjEz
OjMxLjAwMDAwMDAwMCArMDMwMA0KKysrIG15bGludXgvaW5jbHVkZS9uZXQv
c29jay5oCTIwMDQtMDktMDcgMTM6MTQ6MzYuMDAwMDAwMDAwICswMzAwDQpA
QCAtMjAxLDcgKzIwMSw3IEBAIHN0cnVjdCBzb2NrIHsNCiAJd2FpdF9xdWV1
ZV9oZWFkX3QJKnNrX3NsZWVwOw0KIAlzdHJ1Y3QgZHN0X2VudHJ5CSpza19k
c3RfY2FjaGU7DQogCXJ3bG9ja190CQlza19kc3RfbG9jazsNCi0Jc3RydWN0
IHhmcm1fcG9saWN5CSpza19wb2xpY3lbMl07DQorCXN0cnVjdCB4ZnJtX3Bv
bGljeQkqc2tfcG9saWN5WzNdOw0KIAlhdG9taWNfdAkJc2tfcm1lbV9hbGxv
YzsNCiAJc3RydWN0IHNrX2J1ZmZfaGVhZAlza19yZWNlaXZlX3F1ZXVlOw0K
IAlhdG9taWNfdAkJc2tfd21lbV9hbGxvYzsNCg==

---1646943047-1948299716-1094553352=:8637--
