Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbRDDTKH>; Wed, 4 Apr 2001 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131882AbRDDTJ6>; Wed, 4 Apr 2001 15:09:58 -0400
Received: from dial127.za.nextra.sk ([195.168.64.127]:772 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S131886AbRDDTJq>;
	Wed, 4 Apr 2001 15:09:46 -0400
Date: Wed, 4 Apr 2001 15:54:45 +0200
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: Non keyboard trigger of Alt-SysRQ-S-U-B
Message-ID: <20010404155445.A1800@Boris>
In-Reply-To: <3ABE1C70.92CBBF01@umr.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABE1C70.92CBBF01@umr.edu>; from nneul@umr.edu on Sun, Mar 25, 2001 at 10:27:28AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

    Hi Nathan,

I've just made an experimental module which offers syscall to privileged
process, which internally translates itself into real sysrq handler
(handle_sysrq) defined in drivers/char/sysrq.c. It occupates itself 
one of unussed linux system calls (concretely stty - no. 31). 
Makefile and patch for that sysrq.c are included in attached archive. 
(I stronly believe i didn't made it reversed :). 
The patch itself only exports 1 variable and 1 function from sysrq.c, 
that normally aren't.

You can make a daemon, which listens on socket and triggers commands
send by clients. Dont call sysrq+boot until a while needed to sync and
unmount. This check, if sync and/or umount were finished before boot,
should be really done, but it would require more changes in kernel
source. And of course, the security is to be taken in client/server
into account.

Bye                                                                   B.

--opJtzjQTFsWo+cga
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="srq.tar.gz"
Content-Transfer-Encoding: base64

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

--opJtzjQTFsWo+cga--
