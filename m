Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288995AbSAUBkg>; Sun, 20 Jan 2002 20:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288996AbSAUBk0>; Sun, 20 Jan 2002 20:40:26 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:23307 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288995AbSAUBkJ>;
	Sun, 20 Jan 2002 20:40:09 -0500
Date: Sun, 20 Jan 2002 23:39:16 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B6A0D.5000006@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201202321350.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:
> Rik van Riel wrote:

> >I take it you're volunteering to bring ext3, XFS, JFS,
> >JFFS2, NFS, the inode & dentry cache and smbfs into
> >shape so reiserfs won't get unbalanced ?

> If they use writepage(), then the job of balancing cache cleaning is
> done, we just use writepage as their pressuring mechanism.
> Any FS that wants to optimize cleaning can implement a VFS method, and
> any FS that wants to optimize freeing can implement a VFS method, and
> all others can use their generic VM current mechanisms.

It seems you're still assuming that different filesystems will
all see the same kind of load.

Freeing cache (or at least, applying pressure) really is a job
for the VM because none of the filesystems will have any idea
exactly how busy the other filesystems are.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

