Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbRAFFJg>; Sat, 6 Jan 2001 00:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbRAFFJ3>; Sat, 6 Jan 2001 00:09:29 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:52977 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S131466AbRAFFJY>;
	Sat, 6 Jan 2001 00:09:24 -0500
Date: Sat, 6 Jan 2001 06:08:46 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010106060846.A770@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010106054615.A2958@stefan.sime.com> <Pine.GSO.4.21.0101052350460.25336-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101052350460.25336-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Jan 05, 2001 at 11:52:31PM -0500
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 11:52:31PM -0500, Alexander Viro wrote:
> On Sat, 6 Jan 2001, Stefan Traby wrote:
> 
> > Then I tried to unlink the file by running rm lfs.file log.
> > 
> > The rm process (and an ls process that I started after that)
> > are now in "D" state...
> > 
> > root      2934  0.0  0.2  1292  452 pts/5    D    05:38   0:00 ls /ramfs
> > root      2952  0.0  1.5  4028 2384 pts/3    S    05:40   0:00 vi sdlkhfd
> 
> Add UnlockPage(page) at the end of ramfs_writepage().

Shit. You are quite fast. Works.

It was the first D-state case here where sync(1) did not fall
into D-state, too. (ok, I know why :)

-- 

    Stefan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
