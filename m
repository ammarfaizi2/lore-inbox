Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbTFWFGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 01:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbTFWFGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 01:06:07 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:32773 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S265941AbTFWFGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 01:06:05 -0400
Date: Mon, 23 Jun 2003 07:20:04 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.72: system unusable during upload to slow nfs-server
Message-ID: <20030623052004.GA7270@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I rsync some directories to a nfs-mount on a very large harddisk on a
non-udma system. This system can read/write data at about 3-4 megabyte
per second.

If I rsync in 2.4, all happens as you'd expect: the update doesn't go
fast, but the interactivity of the kernel is good while it's running.


In 2.5.7x, it runs really fast for a while (rsync mentions 30 mb/s), and
after a while slows down. Then, a mutt-session on another console lags
about 10-30 seconds when you press a key. top gives 98% IO-wait.

The nfs-server runs 2.4.21-rc7, and the mount is like this:

server:/backup_big on /mnt type nfs (rw,wsize=16384,rsize=16384,hard,intr,posix,tcp,addr=x.x.x.x)

The local machine I'm working on is an Athlon XP-2600 with pre-empt. The
network is 100 mbps with full-duplex. I'm using NFS V3 on both sides.

The interactivity in 2.4 is good, in 2.5.7x is very bad.

Any hints?

Thanks,
Jurriaan
-- 
Baldrick, I would advise you to make the explanation you are about to give
phenomenally good.
	The Black Adder
Debian (Unstable) GNU/Linux 2.5.72 4112 bogomips load av: 2.09 1.65 0.77
