Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130074AbQKFVqX>; Mon, 6 Nov 2000 16:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbQKFVqN>; Mon, 6 Nov 2000 16:46:13 -0500
Received: from smtp-abo-1.wanadoo.fr ([193.252.19.122]:4342 "EHLO
	villosa.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130074AbQKFVqE>; Mon, 6 Nov 2000 16:46:04 -0500
Date: Mon, 6 Nov 2000 22:56:06 +0100
To: Andrea Arcangeli <andrea@suse.de>
Cc: Yann Dirson <ydirson@altern.org>, Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001106225606.A31175@bylbo.nowhere.earth>
In-Reply-To: <20001101174816.A18510@athlon.random> <Pine.LNX.4.21.0011011456430.11112-100000@duckman.distro.conectiva> <20001101220326.A4514@bylbo.nowhere.earth> <20001101220002.A17134@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001101220002.A17134@athlon.random>; from andrea@suse.de on Wed, Nov 01, 2000 at 10:00:02PM +0100
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 10:00:02PM +0100, Andrea Arcangeli wrote:
> On Wed, Nov 01, 2000 at 10:03:27PM +0100, Yann Dirson wrote:
> > On Wed, Nov 01, 2000 at 02:59:01PM -0200, Rik van Riel wrote:
> > 
> > Andrea wrote:
> > > (btw, make sure you're using the -7 revision of the VM-global patch, as it
> > > includes the same MM corruption bugfix that is been included into 18pre18)
> > 
> > Damn, I was using -6.  http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre9/ does not have -7.
> > Neither does your e-mind repository hlinked from linux-mm.
> > 
> > I'm currently running -6 :(
> 
> A -7 to apply to 2.2.18pre17 and _previous_ releases is in the directory
> patches/v2.2/2.2.18pre17/. An equivalent one against 2.2.18pre18 (and probably
> future releases) is in patches/v2.2/2.2.18pre18/.

Now running 2.2.18pre17 + -7 since a few days

The problems I had appear to be gone.  However with this kernel I have
bursts of error messages from nscd (from glibc 2.1.95) like this one taken
from daemon.log:

Nov  5 22:36:17 bylbo nscd: 925: while accepting connection: Cannot allocate memory

They usually appear at cron.daily time, although it looks like I kinda can
reproduce them.  I'm still investigating and narrowing - they seem to avoid
me unfortunately :(  Will launch a tracking job for the night, hopefully
I'll narrow to the single cron job this time.

Anyone seen that ?


> After applying the patch you should make sure there are no rejects with a `find
> -name \*.rej`.  If there aren't rejects all gone right.

I prefer running "patch --dry-run", I hate it when I have to wait for bzip2
and tar :}

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
debian-email:   <dirson@debian.org> |   Support Debian GNU/Linux:
                                    | Cheaper, more Powerful, more Stable !
http://ydirson.free.fr/             | Check <http://www.debian.org/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
