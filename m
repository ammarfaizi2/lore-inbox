Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270665AbUJUIQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270665AbUJUIQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270566AbUJUIEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:04:12 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:38072 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S270408AbUJUIAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:00:05 -0400
Date: Thu, 21 Oct 2004 10:00:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       sam@ravnborg.org
Message-ID: <20041021080007.GA16549@wohnheim.fh-wedel.de>
References: <4176FE65.4000507@osdl.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4176FE65.4000507@osdl.org>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] checkstack: add x86_64 arch. support
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: rddunlap@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org, sam@ravnborg.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch is trivial enough.  Added my line, in case that makes a
difference.

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979

Add support for x86_64 arch. to 'make checkstack' (checkstack.pl).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>

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
