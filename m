Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbTCOI24>; Sat, 15 Mar 2003 03:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbTCOI24>; Sat, 15 Mar 2003 03:28:56 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:36880 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S261340AbTCOI2y>; Sat, 15 Mar 2003 03:28:54 -0500
Date: Sat, 15 Mar 2003 00:39:40 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC] Improved inode number allocation for HTree
Message-ID: <20030315083940.GE18287@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200303102104.h2AL43iZ000875@81-2-122-30.bradfords.org.uk> <20030310212953.57F2310435B@mx12.arcor-online.net> <1047332834.11339.3.camel@serpentine.internal.keyresearch.com> <20030310220254.GA21234@parcelfarce.linux.theplanet.co.uk> <1047679031.2566.616.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047679031.2566.616.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 09:57:12PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Mon, 2003-03-10 at 22:02, Matthew Wilcox wrote:
> > On Mon, Mar 10, 2003 at 01:47:14PM -0800, Bryan O'Sullivan wrote:
> > > Why start?  Who actually uses atime for anything at all, other than the
> > > tiny number of shops that care about moving untouched files to tertiary
> > > storage?
> > > 
> > > Surely if you want to heap someone else's plate with work, you should
> > > offer a reason why :-)
> > 
> > "You have new mail" vs "You have mail".
> 
> "nodiratime" can still help there.

As may noatime.  noatime only prevents the automatic update
of atime on read.  It doesn't (at least in my experience)
prevent utime(2) from updating the atime field.

Using noatime works quite well with at least with mutt which
explicitly uses utime(2) to update atime.  I cannot be
certain but mutt may actually work better with noatime
because then other tools (*biff &co) accesses won't break the
mailer's notion of new mail (mtime > atime).

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
