Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264784AbUD1Ng5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264784AbUD1Ng5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264785AbUD1Ng5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:36:57 -0400
Received: from aun.it.uu.se ([130.238.12.36]:239 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264784AbUD1Ngy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:36:54 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16527.45935.480630.490196@alkaid.it.uu.se>
Date: Wed, 28 Apr 2004 15:36:47 +0200
To: marcelo.tosatti@cyclades.com
Subject: gcc-3.4.0 patches for 2.4.27?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Will you accept patches allowing gcc-3.4.0 to compile
2.4.27 or not? I can understand if you want to be
conservative and not change _anything_ if you don't have to.

gcc-3.4.0 errors out in 2.4.27-pre1 due to (a) inconsistent
FASTCALL declarations, (b) uninlinable inlines, and (c)
-funit-at-a-time which seems to leave unresolved calls to
strcpy() around [gcc optimises sprintf "%s" to strcpy()].
There are also tons of warnings due to cast-as-lvalue
and "+m" asm() constraints.

I currently have a 40KB+ patch for 2.4.27-pre1 which works
for me on i386, UP and SMP. The changes are all backports
from 2.6. I'll do x86_64 and ppc(32) in a few days.

http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-pre1
is the location of the current version.

/Mikael
