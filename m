Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275784AbRJBDQE>; Mon, 1 Oct 2001 23:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275789AbRJBDPz>; Mon, 1 Oct 2001 23:15:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62842 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S275784AbRJBDPq>; Mon, 1 Oct 2001 23:15:46 -0400
To: Nilmoni Deb <ndeb@ece.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/ext2/namei.c: dir link/unlink bug? [Re: mv changes dir timestamp
In-Reply-To: <Pine.LNX.3.96L.1011001150851.16650A-100000@d-alg.ece.cmu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Oct 2001 21:06:44 -0600
In-Reply-To: <Pine.LNX.3.96L.1011001150851.16650A-100000@d-alg.ece.cmu.edu>
Message-ID: <m1vghy3fln.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nilmoni Deb <ndeb@ece.cmu.edu> writes:

> On 1 Oct 2001, Eric W. Biederman wrote:
> 
> > Or vice versa, as touch will also go back in time.
> 
> This is not a good idea because once the user has to remember the exact
> time stamp before the move and put that on the moved dir using touch.

You add a mv -p option to do it for you.
 
> > My question is which semantics are desirable, and why.  I conceed
> > that something has changed.  And that changing the functionality back
> > to the way it was before may be desireable.  But given that the
> > directory is in fact changed my gut reaction is that the new behavior
> > is more correct than the old behavior.
> 
> U r right but most users won't care too much about the ".." link inside
> each dir. Its the other files that really count. If the other files
> remain unchanged then they consider the dir as unchanged.

O.k. So nothing breaks and we just have a suprising change to more
correct behavior.  Given that I don't see the case for making a special
case in the code.  

Eric
