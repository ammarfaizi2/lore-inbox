Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSIAHK0>; Sun, 1 Sep 2002 03:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSIAHK0>; Sun, 1 Sep 2002 03:10:26 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:45527 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S316519AbSIAHKZ>; Sun, 1 Sep 2002 03:10:25 -0400
Subject: 2.5.33 PNPBIOS does not compile
From: Nicholas Miell <nmiell@attbi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 00:14:46 -0700
Message-Id: <1030864488.21055.25.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pnpbios_core.c: In function `call_pnp_bios':
pnpbios_core.c:167: invalid lvalue in unary `&'
pnpbios_core.c:167: invalid lvalue in unary `&'
pnpbios_core.c:169: invalid lvalue in unary `&'
pnpbios_core.c:169: invalid lvalue in unary `&'
pnpbios_core.c: In function `pnpbios_init':
pnpbios_core.c:1276: invalid lvalue in unary `&'
pnpbios_core.c:1276: invalid lvalue in unary `&'
pnpbios_core.c:1277: invalid lvalue in unary `&'
pnpbios_core.c:1277: invalid lvalue in unary `&'
pnpbios_core.c:1278: invalid lvalue in unary `&'
pnpbios_core.c:1278: invalid lvalue in unary `&'
make[2]: *** [pnpbios_core.o] Error 1
make[2]: Target `first_rule' not remade because of errors.
make[1]: *** [pnp] Error 2

... which is the result of the expansion of the Q_SET_SEL and Q2_SET_SEL
macros. 

My guess is that changing the macros so that they use set_limit instead
of _set_limit is what broke things, but I don't understand any of this
x86 segmentation voodoo, so I'm not touching it.

