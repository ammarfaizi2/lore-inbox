Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279325AbRJWII6>; Tue, 23 Oct 2001 04:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279323AbRJWIIt>; Tue, 23 Oct 2001 04:08:49 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:37238 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S279320AbRJWIIf>; Tue, 23 Oct 2001 04:08:35 -0400
Date: Tue, 23 Oct 2001 10:09:41 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-pre6 and 2.4.12-ac5 fail under load
Message-ID: <20011023100941.A721@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13-current-20010108i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've done a stress test which 2.4.12-ac5 fails. I can now reproduce
the problem in 2.4.13-pre6, although it takes much longer there.
It is probably NFS or ethernet driver related.

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

-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
