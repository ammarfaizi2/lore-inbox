Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137159AbREKP4b>; Fri, 11 May 2001 11:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137161AbREKP4V>; Fri, 11 May 2001 11:56:21 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62220 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S137159AbREKP4H>; Fri, 11 May 2001 11:56:07 -0400
Date: Fri, 11 May 2001 17:56:05 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Hans Reiser <reiser@namesys.com>
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010511175605.G28282@burns.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org> <3AFA9AD8.7080203@magenta-netlogic.com> <20010511013726.C31966@emma1.emma.line.org> <3AFBFDB0.5080904@magenta-netlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFBFDB0.5080904@magenta-netlogic.com>; from tmh@magenta-netlogic.com on Fri, May 11, 2001 at 15:56:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2001, Tony Hoyle wrote:

> Matthias Andree wrote:
> 
> > You're not getting data loss, but access denied, when hitting
> > incompatibilities, and it looks like it hits 2.2 hard while 2.4 is less
> > of a problem. Please search the reiserfs list archives for details.
> > vs-13048 is a good search term, I believe.
> 
> Data is lost:

That's not true, at least not in my case. Data is temporarily
inaccessible, and in extreme cases, the Kernel might panic, but I never
suffered from permanent damage. There might be other reasons, old
kernel, old patch, old user-space utilities, hardware flaws. I'm not a
good friend of ReiserFS on Linux 2.2 in production, but let's please
keep honest, regardless of how big the anger may have grown.

> Root can't access the files.

True, catches EACCES.

> Reiserfsck can't repair the files.

Also true, because they're not broken.

> The files that are corrupted are unrelated to the ones exported over NFS 
> (which makes me wonder if it's the same bug).

It's probably not. vs-13048 can usually be rectified (ugly, slow but
usually works on machines even with 256 MB RAM and 1/2 GB swap) by ls
-laR / or treescan -stat /.

> File corruption would begin a couple of hours after the volume was 
> formatted, and become catastrophic within a couple of days.
> 
> Until the fix is merged I'm not going within 100 miles of reiserfs!

Well, it would be really a good idea to consider if the patch might be
merged into ReiserFS 3.5.33, but AFAICS, the ReiserFS team have focused
on getting 3.6 solid. Hans, does ReiserFS 3.6 suffer from vs-13048 or
similar problems with NFS in plain Linux 2.4.4 or does ist still need
patches as 3.5.x does?
