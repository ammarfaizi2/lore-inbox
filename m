Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265697AbRFWWGM>; Sat, 23 Jun 2001 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbRFWWGC>; Sat, 23 Jun 2001 18:06:02 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:47380 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261561AbRFWWFy>; Sat, 23 Jun 2001 18:05:54 -0400
Date: Sun, 24 Jun 2001 00:07:50 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: Two nfsd bugs in 2.4.x
Message-ID: <20010624000750.D2868@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13-current-20010108i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I switched to the kernel nfsd I have troubles exporting my
filesystems. I think in kernel 2.2.x there was no problem, neither was
it with the userspace nfsd. Currently I run kernel 2.4.5pre1 on the
server.

1. When I try to boot one of my diskless clients (kernel 2.0.34), it mounts
its root fs from /opt/boot/client which is on an ext2 fs. But apparently
it hangs when it tries to access lib/ld-linux.so.1 (seen with a network
sniffer). This is a symbolic link pointing to lib/ld-linux.so.1.9.2.
In the kernel log I find:

nfsd Security: lib/ld-linux.so.1 bad export.

2. I cannot any longer mount the server's /usr on certain workstations.
It works on my main workstation which currently runs kernel 2.4.5.
On other workstations I get "permission denied by server". I tried various
kernels (2.0.36, 2.2.3, 2.3.52) and various versions of mount (2.7l, 2.10o).
My /etc/exports contains the line

/usr            *.hjb.de(rw,no_root_squash)

and all my clients are in my local DNS. The syslog shows

rpc.mountd: getfh failed: Operation not permitted

Any help? More info on request.

Thanks,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
