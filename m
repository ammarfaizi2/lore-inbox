Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267226AbUHIVQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267226AbUHIVQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUHIVOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:14:37 -0400
Received: from lakermmtao03.cox.net ([68.230.240.36]:26266 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S267226AbUHIVNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:13:50 -0400
In-Reply-To: <1681.1092065051@redhat.com>
References: <16109.1092044758@redhat.com> <Pine.LNX.4.58.0408072221480.1793@ppc970.osdl.org> <Xine.LNX.4.44.0408080046130.27710-100000@dhcp83-76.boston.redhat.com> <1681.1092065051@redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00F02658-EA49-11D8-BC30-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: mike@halcrow.us, greg@kroah.com, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, dwmw2@infradead.org, arjanv@redhat.com,
       Linus Torvalds <torvalds@osdl.org>, sfrench@samba.org, akpm@osdl.org,
       James Morris <jmorris@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management [try #4]
Date: Mon, 9 Aug 2004 17:13:47 -0400
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One feature that appears to be missing is a key handle or key reference,
essentially a structure for manipulating a key with an additional 
permissions
mask and the ability to be both cloned and revoked.  A clone should have
the same permission mask as the parent, reducible, of course.  When a 
key
reference is revoked it also revokes all cloned references, and their 
clones,
etc.  I guess a clone should be made when passed across a UNIX pipe, as
well as when passed to a child process.  That way I can give some daemon
a key handle to do work for me, then revoke the daemon's handle only, 
not
all the other handles I may have, when I'm done with it.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


