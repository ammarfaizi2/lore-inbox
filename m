Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287200AbSASMrF>; Sat, 19 Jan 2002 07:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287237AbSASMqz>; Sat, 19 Jan 2002 07:46:55 -0500
Received: from AMontpellier-201-1-6-45.abo.wanadoo.fr ([80.13.220.45]:8197
	"EHLO awak") by vger.kernel.org with ESMTP id <S287200AbSASMqj>;
	Sat, 19 Jan 2002 07:46:39 -0500
Subject: Re: rm-ing files with open file descriptors
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alexander Viro <viro@math.psu.edu>
Cc: Matthias Schniedermeyer <ms@citd.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0201190728120.3523-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201190728120.3523-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Jan 2002 13:46:29 +0100
Message-Id: <1011444389.25261.5.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-19 at 13:29, Alexander Viro wrote:
> 
> 
> On 19 Jan 2002, Xavier Bestel wrote:
> 
> > On Sat, 2002-01-19 at 13:16, Matthias Schniedermeyer wrote:
> > > > > Well no. new_fd will refer to a completely new, empty file
> > > > > which has no relation to the old file at all.
> > > > > 
> > > > > There is no way to recreate a file with a nlink count of 0,
> > > > > well that is until someone adds flink(fd, newpath) to the kernel.
> > > > > 
> > > > 
> > > > This *might* work:
> > > > 
> > > > link("/proc/self/fd/40", newpath);
> > > 
> > > cat /proc/<id>/fd/<nr> > whatever
> > > actually works.
> > 
> > Once it's unliked ? I doubt it.
> 
> Egads...  It certainly works, unlinked or not.  Please learn the basics of
> Unix filesystem semantics.

Indeed, it works, but it doesn't with a true symlink. What kind of a
link is that /proc/<id>/fd/<nr> entry ? It's not a symlink even if it
looks like one.

