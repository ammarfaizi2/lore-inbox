Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbUAYOaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 09:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUAYOaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 09:30:46 -0500
Received: from ihme.org ([212.226.113.138]:5530 "EHLO ihme.org")
	by vger.kernel.org with ESMTP id S264353AbUAYOap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 09:30:45 -0500
Date: Sun, 25 Jan 2004 16:30:42 +0200
To: linux-kernel@vger.kernel.org
Subject: i/o wait eating all of CPU on 2.6.1
Message-ID: <20040125143042.GA20274@ihme.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Jaakko Helminen <haukkari@ihme.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have two servers, both of which have more than 300 gigabytes of hard drive
space and those files are made available to the network with samba, nfs and
http and it worked fine with 2.6.0 but when I upgraded to 2.6.1 I noticed
that everything was VERY slow, from a machine that is connected to the other
server with a 100M link, 57kB/s tops. i/o wait eats up all of the cpu.
On the other hand, Apache (and everything else) works very fast when I only
send /dev/zero to a client, since that doesn't need disk operations.

I don't notice anything suspicious in dmesg but since this happens on two
machines and has only happened when upgraded to 2.6.1, it's most likely
because of 2.6.1. I'm downgrading to 2.6.0 (with mremap-patch) today if I
don't figure out what is wrong. Any ideas?

And since I'm not subscribed to Linux Kernel Mailing List, please forward
any replies to me.


-Jaakko Helminen

