Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269014AbRG3RDf>; Mon, 30 Jul 2001 13:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269015AbRG3RDZ>; Mon, 30 Jul 2001 13:03:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:32786 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269014AbRG3RDQ>; Mon, 30 Jul 2001 13:03:16 -0400
Date: Mon, 30 Jul 2001 14:03:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
Cc: Chris Mason <mason@suse.com>, Chris Wedgwood <cw@f00f.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <s5gvgkacqlm.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.33L.0107301358310.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 30 Jul 2001, Patrick J. LoPresti wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
>
> > Exactly what is wrong with doing fsync() on the
> > directory ?
>
> Nothing, except that it requires source code changes to every
> application which expects BSD semantics for these operations.
> Anecdotal evidence suggests at least the MTA authors are resistant to
> making such changes.

You may need to make them anyway for Digital's AdvFS,
IRIX XFS, IBM JFS, Veritas' VXFS and BSD softupdates.

Lets face it, FFS is no longer the only available
filesystem. Don't expect FFS semantics from other
filesystems.

> > Why can't you use a simple wrapper function to
> > do this for you ?
>
> It would not be all that simple; it would have to parse the
> arguments to figure out the containing directories, open() a
> file descriptor on each, and fsync() them.

Hmmm, then maybe we'd just want some flag to fsync()
telling the kernel to also sync the parent directory
of the file and do whatever it needs to do to get the
rename() or link() committed ?

> But it still seems simpler to me just to make it an option in
> the file system.

It's always simpler when it's not YOU who has to
implement it ;)

cheers,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

