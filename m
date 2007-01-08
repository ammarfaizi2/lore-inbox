Return-Path: <linux-kernel-owner+w=401wt.eu-S1161234AbXAHL1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbXAHL1b (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161233AbXAHL1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:27:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37383 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161232AbXAHL1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:27:30 -0500
Date: Mon, 8 Jan 2007 12:27:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mikulas@artax.karlin.mff.cuni.cz, matthew@wil.cx, bhalevy@panasas.com,
       arjan@infradead.org, jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070108112713.GA25857@elf.ucw.cz>
References: <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu> <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu> <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz> <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu> <E1H2qnF-0007sb-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H2qnF-0007sb-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2007-01-05 16:15:41, Miklos Szeredi wrote:
> > > And does it matter? If you rename a file, tar might skip it no matter of 
> > > hardlink detection (if readdir races with rename, you can read none of the 
> > > names of file, one or both --- all these are possible).
> > > 
> > > If you have "dir1/a" hardlinked to "dir1/b" and while tar runs you delete 
> > > both "a" and "b" and create totally new files "dir2/c" linked to "dir2/d", 
> > > tar might hardlink both "c" and "d" to "a" and "b".
> > > 
> > > No one guarantees you sane result of tar or cp -a while changing the tree. 
> > > I don't see how is_samefile() could make it worse.
> > 
> > There are several cases where changing the tree doesn't affect the
> > correctness of the tar or cp -a result.  In some of these cases using
> > samefile() instead of st_ino _will_ result in a corrupted result.
> 
> Also note, that using st_ino in combination with samefile() doesn't
> make the result much better, it eliminates false positives, but cannot
> fix false negatives.

I'd argue false negatives are not as severe.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
