Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289209AbSASMXU>; Sat, 19 Jan 2002 07:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289210AbSASMXK>; Sat, 19 Jan 2002 07:23:10 -0500
Received: from AMontpellier-201-1-6-45.abo.wanadoo.fr ([80.13.220.45]:54788
	"EHLO awak") by vger.kernel.org with ESMTP id <S289209AbSASMW6>;
	Sat, 19 Jan 2002 07:22:58 -0500
Subject: Re: rm-ing files with open file descriptors
From: Xavier Bestel <xavier.bestel@free.fr>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020119131600.A17356@citd.de>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
	<Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com>
	<a2afsg$73g$2@ncc1701.cistron.net> <a2almg$vtl$1@cesium.transmeta.com> 
	<20020119131600.A17356@citd.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Jan 2002 13:22:41 +0100
Message-Id: <1011442962.25240.3.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-19 at 13:16, Matthias Schniedermeyer wrote:
> > > Well no. new_fd will refer to a completely new, empty file
> > > which has no relation to the old file at all.
> > > 
> > > There is no way to recreate a file with a nlink count of 0,
> > > well that is until someone adds flink(fd, newpath) to the kernel.
> > > 
> > 
> > This *might* work:
> > 
> > link("/proc/self/fd/40", newpath);
> 
> cat /proc/<id>/fd/<nr> > whatever
> actually works.

Once it's unliked ? I doubt it.

