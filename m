Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285196AbRL2SV6>; Sat, 29 Dec 2001 13:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbRL2SVs>; Sat, 29 Dec 2001 13:21:48 -0500
Received: from waste.org ([209.173.204.2]:43983 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S285186AbRL2SVg>;
	Sat, 29 Dec 2001 13:21:36 -0500
Date: Sat, 29 Dec 2001 12:21:23 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Dave Jones <davej@suse.de>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
In-Reply-To: <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.43.0112291216360.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Dave Jones wrote:

> On Thu, 27 Dec 2001, Arnaldo Carvalho de Melo wrote:
>
> > > Patch is against kernel 2.4.17, should apply to 2.5 as well.
> > Good job! But please consider splitting the patch per driver and sending it
> > to the respective maintainers.
>
> Someone with far too much time on their hands would be my personal
> hero[*] if they were to write a script (in language of their choice) to
> parse a diff, extract filename, and do lookup in a flat text file
> to find a list of maintainers/interested parties.
>
> Imagine a patch against devfs..
>
> $ cclist my.devfs.patch.diff
> Richard Gooch <rgooch@atnf.csiro.au>
> Alexander Viro <viro@math.psu.edu>
>
> SCNR 8-)
>
> This 'little black book of addresses' doesn't have to be anything
> wonderful, but its tedious work for someone to make the textfile
> mapping the various source files to email addresses.
>
> Someone (Alan?) suggested having something like a web interface
> allowing anyone interested in any particular file to register
> their interest, and get added to the cclist for that file.
> Which is also a cool idea.

The easy way to do this is to build a tree mirroring the kernel tree
with each file containing the addresses of the interest list. Directories
would contain a .interest file to indicate interest in the entire
directory.

Then a 'curl http://www.kernel.org/interest?file=foo/bar/baz' gets you the
interest list.

Unfortunately you need some sort of confirmation step around the 'add
interest' bit to avoid people adding you to the root of the tree.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

