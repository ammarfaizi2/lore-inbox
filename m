Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270515AbUJUAVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270515AbUJUAVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270439AbUJUAUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:20:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:42668 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S270592AbUJUATc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:19:32 -0400
Message-ID: <4176FE65.4000507@osdl.org>
Date: Wed, 20 Oct 2004 17:10:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       joern@wohnheim.fh-wedel.de, sam@ravnborg.org
Subject: [PATCH] checkstack: add x86_64 arch. support
Content-Type: multipart/mixed;
 boundary="------------050902080507080904060700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050902080507080904060700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


---

--------------050902080507080904060700
Content-Type: text/x-patch;
 name="checkstack_x64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="checkstack_x64.patch"


Add support for x86_64 arch. to 'make checkstack' (checkstack.pl).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 scripts/checkstack.pl |    3 +++
 1 files changed, 3 insertions(+)

diff -Naurp ./scripts/checkstack.pl~checkstack_x64 ./scripts/checkstack.pl
--- ./scripts/checkstack.pl~checkstack_x64	2004-10-18 14:53:45.000000000 -0700
+++ ./scripts/checkstack.pl	2004-10-20 16:52:14.434261304 -0700
@@ -39,6 +39,9 @@ my (@stack, $re, $x, $xs);
 	} elsif ($arch =~ /^i[3456]86$/) {
 		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
 		$re = qr/^.*[as][du][db]    \$(0x$x{1,8}),\%esp$/o;
+	} elsif ($arch eq 'x86_64') {
+		#    2f60:	48 81 ec e8 05 00 00 	sub    $0x5e8,%rsp
+		$re = qr/^.*[as][du][db]    \$(0x$x{1,8}),\%rsp$/o;
 	} elsif ($arch eq 'ia64') {
 		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
 		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;

--------------050902080507080904060700--
