Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRI1VDx>; Fri, 28 Sep 2001 17:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276313AbRI1VDn>; Fri, 28 Sep 2001 17:03:43 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:2512 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S276312AbRI1VDX>; Fri, 28 Sep 2001 17:03:23 -0400
Date: Fri, 28 Sep 2001 22:03:42 +0100
From: Chris Wilson <chris@chris-wilson.co.uk>
To: linux-kernel@vger.kernel.org
Subject: NFS client woes [kernel 2.4.10]
Message-ID: <20010928220342.A18562@florence.intimate.mysticnet.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me if you have any suggestions.]

I'm a bit hazy on the details, but the synopsis is:

NFSv3 filesystems, same problem when mounted from either an IRIX 6.5.12m
or Linux/i386 2.4.10 server.

2.4.7: all files are visible all of the time.
2.4.10: some files are invisible to some processes.

The processes that I have noticed to be affected are the likes of
netscape, all gtk applications and find; perl globbing and its readdir
function similarly miss files. OTOH, grep and ls function fine.

I'm not certain [read: no idea] what the connection is between the files 
that do disappear. It does not appear to be simply inode related, but
those modified by the Linux client do seem more vulnerable.

Unfortunately, I only had time to switch back in an old kernel and
confirm the issue before leaving work. The diff inside fs/nfs
appeared small, but so do icebergs. ;)
-- 
 Chris Wilson                 {^_`}                 spam to bit.bucket@dev.null 
                Carol says "289 == 2 * (25 * (1 + 5) - 4) - 3."
