Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRJVN7Y>; Mon, 22 Oct 2001 09:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278811AbRJVN7O>; Mon, 22 Oct 2001 09:59:14 -0400
Received: from mout01.kundenserver.de ([195.20.224.132]:25127 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S278810AbRJVN7K>; Mon, 22 Oct 2001 09:59:10 -0400
Date: Mon, 22 Oct 2001 16:00:18 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: ac5 fails in stress test
Message-ID: <20011022160017.A745@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13-current-20010108i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've done a stress test which 2.4.12-ac5 fails. I cannot reproduce
the problem in 2.4.13-pre6. It is probably NFS or ethernet driver
related.

The test consists of mounting a NFS volume from a file server (kernel
2.4.10), changing to a directory on that volume and starting to rip
a CD. Using abcde and distmp3, I distribute the load of converting the
wav files to ogg on several machines.

Sometime during the conversion the system loses its network connection,
ping doesn't work anymore, NFS stalls. Even after unload and reload of
the network driver the network card doesn't work anymore. A reboot is
necessary. There are no useful messages in the logs. I guess I use NFSv3
(how can I tell exactly?).

Hardware: AMD K6/2-400, 256 MB RAM (using KDE 2.2.1, about 40 MB of swap
are used too, but about 150 MB are in the cache, so this seems to be OK),
Matrox G450, Via Rhine II based network card, SB Live 1024 with Alsa
driver.

Also, the interactive feel of 2.4.13-pre6 is much better than ac5 and the
load average is much lower (about 2.5 versus 5).

Regards,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
