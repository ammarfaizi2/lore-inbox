Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271882AbRIDCIC>; Mon, 3 Sep 2001 22:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271881AbRIDCHw>; Mon, 3 Sep 2001 22:07:52 -0400
Received: from mailhost.opengroup.fr ([62.160.165.1]:14516 "EHLO
	mailhost.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S271878AbRIDCHf>; Mon, 3 Sep 2001 22:07:35 -0400
Date: Tue, 4 Sep 2001 04:07:51 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: Alexander Viro <viro@math.psu.edu>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <Pine.GSO.4.21.0109011226580.18705-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.31.0109040317500.16612-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2001, Alexander Viro wrote:

> IMO a part of the problem is that we are mixing "I'm not asking that
> to be writable" with "I won't let you write".  The former belongs
> to the mounting side, the latter - to filesystem.

In addition to this, I would like to be sure that a (local or remote)
file system that is not mounted r/w will not be affected by local activity
(eg. not even if I pull the power cord).

> Notice that setups along the lines "mount /dev/sda5 read-only on
> /home/jail/pub and read-write on /home/ftp/pub" are not that
> unreasonable, so even for local filesystems it might make sense.
>
> IOW, I suspect that right solution would have two separate layers -
> 	* does anyone get write access under that mountpoint? (VFS)
> 	* is this fs asked to handle write access and had it agreed with that?
> (filesystem)

Then a mount point could be compared to the notion of view in a database,
right ? Sounds nice.

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:saffroy@ri.silicomp.fr

