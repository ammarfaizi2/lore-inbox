Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268669AbUHaOmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268669AbUHaOmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUHaOmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:42:09 -0400
Received: from f12.mail.ru ([194.67.57.42]:22802 "EHLO f12.mail.ru")
	by vger.kernel.org with ESMTP id S268669AbUHaOmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:42:06 -0400
From: Kirill Korotaev <kksx@mail.ru>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix of wrong ipt debug messages
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 192.168.0.129 via proxy [195.133.213.201]
Date: Tue, 31 Aug 2004 18:42:05 +0400
Reply-To: Kirill Korotaev <kksx@mail.ru>
Content-Type: multipart/mixed;
	boundary="----cWPqfATj-6B1df8ylfyPaHH8z:1093963325"
Message-Id: <E1C29pl-000H27-00.kksx-mail-ru@f12.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------cWPqfATj-6B1df8ylfyPaHH8z:1093963325
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit

This patch fixes wrong ipt debug messages.
The problem is that when CONFIG_NETFILTER_DEBUG is set,
parp_redo() can flood debug output like this:

Mar 13 19:57:19 ts1 nf_hook: hook 0 already set.
Mar 13 19:57:19 ts1 skb: pf=0 (unowned) dev=eth0 len=46
.......

Kirill


------cWPqfATj-6B1df8ylfyPaHH8z:1093963325
Content-Type: application/octet-stream; name="diff-ipt-nfdbgarp-20030317"
Content-Disposition: attachment; filename="diff-ipt-nfdbgarp-20030317"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNC4yMC0wMTl0ZXN0MDAyL25ldC9pcHY0L2FycC5jCVRodSBNYXIgMTMgMTM6
MTU6NTEgMjAwMworKysgbGludXgtMi40LjIwLTAxOXRlc3QwMDMvbmV0L2lwdjQvYXJwLmMJTW9u
IE1hciAxNyAxMzo0ODowOCAyMDAzCkBAIC01OTcsNiArNTk3LDkgQEAKIAogc3RhdGljIHZvaWQg
cGFycF9yZWRvKHN0cnVjdCBza19idWZmICpza2IpCiB7CisjaWYgZGVmaW5lZChDT05GSUdfTkVU
RklMVEVSKSAmJiBkZWZpbmVkKENPTkZJR19ORVRGSUxURVJfREVCVUcpCisJc2tiLT5uZl9kZWJ1
ZyA9IDA7CisjZW5kaWYKIAlhcnBfcmN2KHNrYiwgc2tiLT5kZXYsIE5VTEwpOwogfQogCg==

------cWPqfATj-6B1df8ylfyPaHH8z:1093963325--
