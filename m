Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277875AbRJKAiR>; Wed, 10 Oct 2001 20:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277859AbRJKAiH>; Wed, 10 Oct 2001 20:38:07 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60409
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277811AbRJKAhu>; Wed, 10 Oct 2001 20:37:50 -0400
Date: Wed, 10 Oct 2001 17:38:11 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Doug McNaught <doug@wireboard.com>
Cc: Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
Message-ID: <20011010173811.C3795@mikef-linux.matchmail.com>
Mail-Followup-To: Doug McNaught <doug@wireboard.com>,
	Lew Wolfgang <wolfgang@sweet-haven.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com> <m3elob3xao.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3elob3xao.fsf@belphigor.mcnaught.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 07:11:43PM -0400, Doug McNaught wrote:
> Lew Wolfgang <wolfgang@sweet-haven.com> writes:
> 
> > Hi Folks,
> > 
> > I was looking for some scripts to backup ext2 partitions
> > to multiple CDR's when I stumbled onto "cdbackup" at
> > http://www.cableone.net/ccondit/cdbackup/.
> > 
> > Alas, there is a warning saying:
> > 
> > "WARNING! When using this program under Linux, be sure not to use
> >  dump with kernels in the 2.4.x series. Using dump on an ext2
> >  filesystem has a very high potential for causing filesystem
> >  corruption.  As of kernel version 2.4.5, this has not been
> >  resolved, and it may not be for some time."
> > 
> > I don't recall any problems like this, does anyone have
> > additional comments?
> 
> I'm pretty sure this is because dump reads the block device directly
> (which is cached in the buffer cache), while the file data for cached
> files lives in the page cache, and the two caches are no longer
> coherent (as of 2.4).
>

IIRC, 2.2 didn't have a coherent buffer and page cache also.

I.E. if you "cat /dev/hda > /dev/null" you wouldn't be able to expect any
speedup when reading through the mounted filesystem (except for meta-data?).

Am I wrong?  Has Linux ever had a coherent page and buffer cache?
