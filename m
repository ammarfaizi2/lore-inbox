Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRB1SIC>; Wed, 28 Feb 2001 13:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRB1SHj>; Wed, 28 Feb 2001 13:07:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41190 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129143AbRB1SHc>;
	Wed, 28 Feb 2001 13:07:32 -0500
Date: Wed, 28 Feb 2001 13:07:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David L. Parsley" <parsley@linuxjedi.org>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <3A9D3FD0.76E6457B@linuxjedi.org>
Message-ID: <Pine.GSO.4.21.0102281302230.7107-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, David L. Parsley wrote:

> Alexander Viro wrote:
> > > Evil idea of the day: non-directory (even non-existant) mount points and
> > > non-directory mounts. So then "mount --bind /etc/foo /dev/bar" works.
> > 
> > Try it. It _does_ work.
> 
> Yeah, mount --bind is cool, I've been using it on one of my projects
> today.  But - maybe I'm just not thinking creatively enough - what are
> the advantages of mount --bind versus just symlinking?

1) Correctly working ".." (obviously relevant only for directories)
2) Try to create symlinks on read-only NFS mount. For bonus points, try
to do that one one client without disturbing everybody else.
3) Try to make it different for different users, for that matter.

> Also, I tried mount --bind fileone filetwo, and it fails if filetwo
> doesn't exist. ('mount point filetwo doesn't exist').  Is that supposed
> to work?  (using mount from latest redhat beta)

Nope. It does exactly what it should - changing that is a too large
can of worms I simply don't want to touch.

> BTW, pivot_root is nifty, too. ;-)

Thank Werner for that ;-)

