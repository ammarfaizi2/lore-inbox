Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSFBVfF>; Sun, 2 Jun 2002 17:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSFBVfE>; Sun, 2 Jun 2002 17:35:04 -0400
Received: from fungus.teststation.com ([212.32.186.211]:64524 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S314422AbSFBVfD>; Sun, 2 Jun 2002 17:35:03 -0400
Date: Sun, 2 Jun 2002 23:34:59 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMB filesystem
In-Reply-To: <3CFA875D.1050300@linkvest.com>
Message-ID: <Pine.LNX.4.44.0206022319290.27283-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, Jean-Eric Cuendet wrote:

> What do you think of implementing it that way? Comments?

I would do the browsing as one part and the smb file access as another.
That could allow a user to choose browsing implementation and file access
implementation independently. On the network level they have "nothing" in
common.

For info on user-space filesystems you should spend some more time with
google. There are people out there that have done that.


The browsing can be done as an add-on to autofs (in some form) or as a
userspace filesystem of its own.

Currently autofs has a problem where it won't show the mountpoints of
non-mounted directories, but I think you would run into that problem too.
(short version of the problem: how do you prevent 'ls -l' from mounting
 all filesystems in a directory?)

/Urban

