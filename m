Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbULOWcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbULOWcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbULOWcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:32:41 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:39371 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262517AbULOWch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:32:37 -0500
Date: Wed, 15 Dec 2004 23:32:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bootcache
Message-ID: <20041215223235.GA28286@dualathlon.random>
References: <1103044268.16231.156.camel@watt.suse.com> <20041214173514.GH16322@dualathlon.random> <1103047840.16231.160.camel@watt.suse.com> <20041214184312.GP16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214184312.GP16322@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finished the pagecache granularity feature of bootcache here
~andrea/bootcache-2.6.8-2 .

Only done basic testing so far. Example:

<b:dentry> /usr/local/sbin/less
<b:inode> /tmp/log <0:8>
<b:dentry> /root/bin/less
<b:dentry> /usr/local/bin/less
<b:dentry> /usr/bin/less
<b:inode> /usr/bin/less <0:8> <8:8> <16:8> <24:8> <32:8> <40:8> <48:8> <56:8> <64:8> <72:8> <80:8> <88:8> <96:8> <104:8> <112:8> <120:8> <144:8> <152:8> <160:8> <168:8> <176:8> <184:8> <192:8> <200:8> <208:8> <216:8> <224:8> <232:8> <240:8> <248:8> <256:8> <264:8> <272:8> <280:8> <288:8> <296:8> <304:8> <312:8> <320:8> <328:8> <128:8> <136:8>
<b:dentry> /usr/bin/.sysless
<b:dentry> /etc/sysless
<b:dentry> /etc/lesskey.bin
<b:inode> /etc/lesskey.bin <0:8>
<b:dentry> /meminfo
<b:dentry> /root/bin/sh
<b:dentry> /usr/local/bin/sh
<b:dentry> /usr/bin/sh
<b:dentry> /usr/X11R6/bin/sh
<b:dentry> /meminfo
<b:dentry> /sbin/lessopen.sh
<b:dentry> /usr/sbin/lessopen.sh
<b:dentry> /usr/local/sbin/lessopen.sh
<b:dentry> /root/bin/lessopen.sh
<b:dentry> /usr/local/bin/lessopen.sh
<b:dentry> /usr/bin/lessopen.sh
<b:inode> /usr/bin/lessopen.sh <0:8>
<b:dentry> /meminfo
<b:dentry> /usr/local/sbin/mktemp
<b:dentry> /root/bin/mktemp
<b:dentry> /usr/local/bin/mktemp
<b:dentry> /usr/bin/mktemp
<b:dentry> /usr/X11R6/bin/mktemp
<b:dentry> /tmp/less.1iVAj3
<b:dentry> /tmp/less.qwT7w3
<b:dentry> /sbin/file
<b:dentry> /usr/sbin/file
<b:dentry> /usr/local/sbin/file
<b:dentry> /root/bin/file
<b:dentry> /usr/local/bin/file
<b:dentry> /usr/bin/file
<b:inode> /usr/bin/file <0:8> <8:8> <16:8> <24:8> <32:8> <40:8> <48:8> <56:8> <64:8> <72:8> <80:8>
<b:dentry> /root/.magic
<b:dentry> /usr/share/misc
<b:dentry> /usr/share/misc/magic.mgc
<b:inode> /usr/share/misc/magic.mgc <0:8> <8:8> <16:8> <24:8> <32:8> <40:8> <48:8> <56:8> <64:8> <72:8> <80:8> <88:8> <96:8> <104:8> <112:8> <120:8> <128:8> <136:8> <144:8> <152:8> <160:8> <168:8> <176:8> <184:8> <192:8> <200:8> <208:8> <216:8> <224:8> <232:8> <240:8> <248:8> <256:8> <264:8> <272:8> <280:8> <288:8> <296:8> <304:8> <312:8> <320:8> <328:8> <336:8> <344:8> <352:8> <360:8> <368:8> <376:8> <384:8> <392:8> <400:8> <408:8> <416:8> <424:8> <432:8> <440:8> <448:8> <456:8> <464:8> <472:8> <480:8> <488:8> <496:8> <504:8> <512:8> <520:8> <528:8> <536:8> <544:8> <552:8> <560:8> <568:8> <576:8> <584:8> <592:8> <600:8> <608:8> <616:8> <624:8> <632:8> <640:8> <648:8> <656:8> <664:8> <672:8> <680:8> <688:8> <696:8> <704:8> <712:8> <720:8> <728:8> <736:8> <744:8> <752:8> <760:8> <768:8> <776:8> <784:8> <792:8> <800:8> <808:8> <816:8> <824:8>
<b:dentry> /root/bin/rm
<b:dentry> /usr/local/bin/rm
<b:dentry> /usr/X11R6/bin/rm
<b:dentry> /meminfo
<b:dentry> /sbin/xselection
<b:dentry> /usr/sbin/xselection
<b:dentry> /usr/local/sbin/xselection
<b:dentry> /root/bin/xselection
<b:dentry> /usr/local/bin/xselection
<b:dentry> /usr/bin/xselection

This is in sector units, to optimize for space (arch indipendent of course).

I could compress the ranges nicely with a timer: the timer is needed to flush
the last entry. If it wasn't for the last entry before the file is closed, I
wouldn't need a timer. OTOH the above is quite nice too, so we see exactly how
the pagecache is being allocated.

Userspace must be robust against missing pieces of the trace, when a
regexp fail userspace should just jump to the next line. This because
we're working with a ring buffer, and if userspace doesn't keep up, the
buffer will overflow. The size of the ring is only 1 page, I could
increase it if overflows happen in practice (I didn't see overflows yet,
but the more data we add, the more likely they could happen).
