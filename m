Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264066AbRFYVs3>; Mon, 25 Jun 2001 17:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRFYVsS>; Mon, 25 Jun 2001 17:48:18 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:1010 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264066AbRFYVsE>; Mon, 25 Jun 2001 17:48:04 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106252147.f5PLlPJt025763@webber.adilger.int>
Subject: Re: EXT2 Filesystem permissions (bug)?
In-Reply-To: <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net>
 "from Shawn Starr at Jun 25, 2001 05:33:32 pm"
To: Shawn Starr <spstarr@sh0n.net>
Date: Mon, 25 Jun 2001 15:47:25 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Star writes:
> Is this a bug or something thats undocumented somewhere?
> 
> d--------T
> and
> drwSrwSrwT
> 
> are these special bits? I'm not aware of +S and +T

---S------ = setuid (normally shows up as "s" if "x" is also set)
------S--- = setgid (normally shows up as "s" if "x" is also set)
---------T = sticky bit (prevents non-owner from deleting a file in
                         world-writable directory like /tmp)

See chmod(1) for this info.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
