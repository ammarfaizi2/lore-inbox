Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272549AbRIPRGj>; Sun, 16 Sep 2001 13:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272560AbRIPRGa>; Sun, 16 Sep 2001 13:06:30 -0400
Received: from m3d.uib.es ([130.206.132.6]:60823 "EHLO m3d.uib.es")
	by vger.kernel.org with ESMTP id <S272549AbRIPRGW>;
	Sun, 16 Sep 2001 13:06:22 -0400
Date: Sun, 16 Sep 2001 19:06:45 +0200 (MET)
From: Ricardo Galli <gallir@m3d.uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0109161856380.31311-100000@m3d.uib.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Rik van Riel wrote:
>
> > Is there a way to tell the VM to prune its cache? Or a way to limit
> > the amount of cache it uses?
>
> Not yet, I'll make a quick hack for this when I get back next
> week. It's pretty obvious now that the 2.4 kernel cannot get
> enough information to select the right pages to evict from
> memory.

....

On Sun, 16 Sep 2001, Jeremy Zawodny wrote:
>
> Agreed. I'd be great if there was an option to say "Don't swap out
> memory that was allocated by these programs. If you run out of disk
> buffers, toss the oldest ones and start re-using them."

More easy though (for cases of listening mp3's and backups): cache pages
that were accesed only "once"(*) several seconds ago must be discarded
first. It only implies a check against an access counter and a "last
accesed"  epoch fields of the page.

(*) Or by the same process/process group in a very short period, i.e. the
last-access timestamp should be updated only if the previous access was
few seconds ago.


--ricardo

