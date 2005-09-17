Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVIQP2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVIQP2A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIQP2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:28:00 -0400
Received: from main.gmane.org ([80.91.229.2]:47580 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751117AbVIQP2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:28:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [i386 BOOT CODE] kernel bootable again
Date: Sat, 17 Sep 2005 17:26:14 +0200
Message-ID: <1rhnij9opqgby$.4jlz2jfqsmkc$.dlg@40tude.net>
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192> <432722A1.8030302@tuxrocks.com> <43272B9D.1030301@zytor.com> <33296.85.68.36.53.1126690932.squirrel@212.11.36.192>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-16-48.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005 11:42:12 +0200 (CEST), Pascal Bellard wrote:

> The bootblock code is 497 bytes long. It must as simple as possible.
> Complex algorithms like fingerprinting can't be used.
> 
> Geometry detection works with usual floppies. This patch goal is to
> support them like < 2.6 bootblocks did and fix 1M limitation and
> special formatting like 1.68M floppies.
> 
> Geometry detection may work with non-traditional floppies but is not
> designed to.

This is probably a stupid suggestion, but here it goes anyway: the
kernel has to be written on disk by something, right?

So if the "something" knows (or can get to know) the sector/tracks
layout of the disk it's writing the kernel onto, it could store this
information in the bootblock (is there space for that?). The bootblock
code would then just read this info and use it.

Of course, this would mean that making a kernel-bootable floppy
wouldn't be as simple as cp'ing the kernel image to /dev/fdwhatever,
but if a script/program designed to do this was included with the
kernel source (it wouldn't be too big ...) ...

-- 
Giuseppe "Oblomov" Bilotta

"Da grande lotterò per la pace"
"A me me la compra il mio babbo"
(Altan)
("When I grow up, I will fight for peace"
 "I'll have my daddy buy it for me")

