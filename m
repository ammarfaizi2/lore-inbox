Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbSJHN2i>; Tue, 8 Oct 2002 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbSJHN2h>; Tue, 8 Oct 2002 09:28:37 -0400
Received: from elin.scali.no ([62.70.89.10]:59400 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261608AbSJHN2g>;
	Tue, 8 Oct 2002 09:28:36 -0400
Subject: Re: [PATCH] direct-IO API change
From: Terje Eggestad <terje.eggestad@scali.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0210041621170.2526-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210041621170.2526-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Scali AS
Message-Id: <1034084036.1593.7.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 08 Oct 2002 15:33:56 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On lør, 2002-10-05 at 01:23, Linus Torvalds wrote:
> On Fri, 4 Oct 2002, Andrew Morton wrote:
> > 
> > Because the file handle which we have is for /dev/raw/raw0,
> > not for /dev/hda1.
> > 
> > The raw driver binds to major/minor, not a file*.  I considered
> > changing that (change userspace to pass the open fd).  But didn't.
> 
> Ok. I'd really rather have a cleaner internal API and break the raw driver 
> for a while, than have a silly API just because the raw driver uses it.
> 
> Especially since I thought that O_DIRECT on the regular file (or block
> device) performed about as well as raw does anyway these days? Or is that
> just one of my LSD-induced flashbacks?
> 

Well, somewhat LSD induced. /dev/raw/rawN has a merit for shared disk.
Databases (Read Oracle) most notably need raw devices for parallell
databases. It would GREATLY benefit from a cluster aware fs with
O_DIRECT support, Sistina added that to their closed source GFS 5.x. 

Working with blockdevices are pure evil in my view anyway, but until a
OSS FS that is cluster aware are a part of a vanilla kernel, I'm afraid
that /dev/raw/rawN are a necessary evil 

> 		Linus
> 

TJ

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

