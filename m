Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSDNKf5>; Sun, 14 Apr 2002 06:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311735AbSDNKf4>; Sun, 14 Apr 2002 06:35:56 -0400
Received: from fungus.teststation.com ([212.32.186.211]:25095 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S290289AbSDNKf4>; Sun, 14 Apr 2002 06:35:56 -0400
Date: Sun, 14 Apr 2002 12:35:50 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: K Shyam <kshyam@sasken.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: symlink support for sambafs.
In-Reply-To: <Pine.LNX.4.33L2.0204131751530.2303-100000@pcz-kshyam.sasken.com>
Message-ID: <Pine.LNX.4.33.0204131546450.5127-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2002, K Shyam wrote:

> Hello;
> Does linux kernel have symlink support for sambfs ? I tried doing a
> search on the internet and i obtained a site that gives patches till
> version 2.4.0.The address is :
> http://131.130.199.155/~aoe/mystuff/smb.symlinks/
> Do the latest versions of the kernel have support for symlinks in smbfs ?

No.

> I would like to know whether anyone has experiemented with it before i
> jump into putting my own effort into porting the code that is already present
> to the current kernel.
> Finally is symlinks in sambafs a security hazard and hence it is not
> implemented ?

No, that's not why.

This patch uses its own format to store symlinks in. I know cygwin also
stores symlinks in a special format, and it would be nice if it could use
the same (if possible). It may have been something else I didn't like
about the patch too.

Now there is also a potential conflict with the work being done on the
unix extensions to SMB which allows a samba server to better serve files
to a unix client. This includes symlinks.

/Urban

