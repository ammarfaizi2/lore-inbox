Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272280AbTHDW1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272282AbTHDW1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:27:11 -0400
Received: from aneto.able.es ([212.97.163.22]:17375 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S272280AbTHDW1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:27:06 -0400
Date: Tue, 5 Aug 2003 00:27:04 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: module-init-tools and 2.4
Message-ID: <20030804222704.GC5409@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have some problems with new module utils working in compatibility mode.
I use kernel 2.4 and OSS sound, so I have in my /etc/modules.conf:

alias sound emu10k1

With this:

modprobe -c | grep sound:
path[sound]=/lib/modules/sound
alias char-major-14 soundcore
alias sound emu10k1
alias sound-slot-0 snd-emu10k1

If I add 'alias sound-slot-0 null' or 'alias sound-slot-0 off', run depmod,
the still:

alias sound-slot-0 snd-emu10k1

Even with 'alias sound-slot-0 emu10k1', it works the same.

Should not my alias override the defaults ?

The effect is that initscripts try to load both oss and alsa...

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like
sex:
werewolf.able.es                         \           It's better when it's
free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre10-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.7mdk))
