Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTLPTkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTLPTkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:40:52 -0500
Received: from cv48.neoplus.adsl.tpnet.pl ([80.54.218.48]:18445 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S262161AbTLPTkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:40:49 -0500
Date: Tue, 16 Dec 2003 20:45:47 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More MODULE_ALIASes
Message-ID: <20031216194546.GA2250@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215060838.A08CD2C18C@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Three more MODULE_ALIASes. Trivial, but useful if people want things
> to "just work" in 2.6.0.
>
> If you drop this I'll just keep collecting them.

BTW, I'm reminding about aliases mentioned by me few weeks ago
(here: http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/1263.html),
which could be built into appropriate modules (here in modprobe.conf
format):

alias ppp-compress-21 bsd_comp
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate
alias iso9660 isofs
alias block-major-11 sr_mod
alias char-major-21-* sg

Also note that MODULE_ALIAS_BLOCKDEV_MAJOR doesn't work up to test11,
because for e.g. /dev/fd0 kernel calls modprobe with block-major-2 (in
drivers/block/genhd.c?), but MODULE_ALIAS_BLOCKDEV_MAJOR(FLOPPY_MAJOR)
adds "block-major-2-*" alias.
(similar problem with MODULE_ALIAS_CHARDEV_MAJOR was fixes few releases
 ago by changing requet_module call in fs/chsr_dev.c - in 1.1414.1.23)


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/
