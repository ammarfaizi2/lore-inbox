Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSH0BGI>; Mon, 26 Aug 2002 21:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318317AbSH0BGI>; Mon, 26 Aug 2002 21:06:08 -0400
Received: from dp.samba.org ([66.70.73.150]:44250 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318123AbSH0BGH>;
	Mon, 26 Aug 2002 21:06:07 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15722.53442.363962.263115@argo.ozlabs.ibm.com>
Date: Tue, 27 Aug 2002 11:07:14 +1000 (EST)
To: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix drivers/char/Config.in bogon
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

You deleted a `fi' rather than an `else' in drivers/char/Config.in.
Here's a patch to fix it.

Paul.

diff -urN linux-2.5/drivers/char/Config.in pmac-2.5/drivers/char/Config.in
--- linux-2.5/drivers/char/Config.in	Tue Aug 27 07:03:08 2002
+++ pmac-2.5/drivers/char/Config.in	Tue Aug 27 09:40:53 2002
@@ -57,7 +57,7 @@
    bool 'Enable Qtronix 990P Keyboard Support' CONFIG_QTRONIX_KEYBOARD
    if [ "$CONFIG_QTRONIX_KEYBOARD" = "y" ]; then
      define_bool CONFIG_IT8172_CIR y
-   else
+   fi
    bool 'Enable Smart Card Reader 0 Support ' CONFIG_IT8172_SCR0
    bool 'Enable Smart Card Reader 1 Support ' CONFIG_IT8172_SCR1
 fi
