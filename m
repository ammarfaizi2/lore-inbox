Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbTCLMcC>; Wed, 12 Mar 2003 07:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263123AbTCLMcC>; Wed, 12 Mar 2003 07:32:02 -0500
Received: from pop.gmx.de ([213.165.64.20]:48291 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261555AbTCLMcB> convert rfc822-to-8bit;
	Wed, 12 Mar 2003 07:32:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Date: Wed, 12 Mar 2003 13:38:42 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net> <200303121138.31387.torsten.foertsch@gmx.net> <20030312104741.A9625@infradead.org>
In-Reply-To: <20030312104741.A9625@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303121338.46661.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 12 March 2003 11:47, Christoph Hellwig wrote:
> On Wed, Mar 12, 2003 at 11:38:27AM +0100, Torsten Foertsch wrote:
> > Next question, is there a way to get the dentry and vfsmount of /? I mean
> > not current->fs->root and current->fs->rootmnt. They can be chrooted. I
> > mean the real /.
>
> No.  Esecially as there is not single "real" root.

That means one can build a system with 2 (or more) completely independent file 
system areas combining chroot() and pivot_root(), doesn't it?

                                 fork()
                                   |
                   +---------------+--------------+
                   |                              |
             chroot /area1                        |
                   |                              |
             signal parent ====================> pause
                   |                              |
                  ...                        pivot_root /area2
                                                  |
                                                 ...

Torsten
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+bypWwicyCTir8T4RAuZ6AJ9ACvyIrNDm0dNLNHeTCZzlbJHqSwCeIIAf
8bMEv3HTsutmMpfACakcMlI=
=mNdh
-----END PGP SIGNATURE-----
