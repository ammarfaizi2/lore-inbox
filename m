Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTGKBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269746AbTGKBSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:18:15 -0400
Received: from aneto.able.es ([212.97.163.22]:55762 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S269745AbTGKBSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:18:06 -0400
Date: Fri, 11 Jul 2003 03:32:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.4.22-pre4] hangs on init start with 'block clobbered'
Message-ID: <20030711013244.GA2392@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Plain 2.4.22-pre4 hangs when tries to launch init. booting to runlevel 5 I get:

INIT: version 2.85 booting
INIT: Entering runlevel 5

malloc: block on free list clobbered
Stopping myself...Kernel panic: Attempted to kill init!

If i try to boot in singleuser (runlevel 1), the booting process just
stops after the version line.

Any ideas ?

Notes:
- Kernel is built with gcc-3.3.1 prerelease
- Previous kernels work fine (built with plain 3.3)(I did nor try -pre3)
- -pre2 does not emit the 'Entering...' message. ???

So I tend to blame gcc. Will try to rebuild -pre2 with gcc-3.3.1 to see
if the compiler is the reason. But if anyone has a clue, I would be
grateful.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
