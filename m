Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317995AbSFSULG>; Wed, 19 Jun 2002 16:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317994AbSFSULF>; Wed, 19 Jun 2002 16:11:05 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:54405 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S317995AbSFSUK7>; Wed, 19 Jun 2002 16:10:59 -0400
Date: Wed, 19 Jun 2002 21:10:51 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christopher Li <chrisl@gnuchina.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020619211051.E5119@redhat.com>
References: <20020619113734.D2658@redhat.com> <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain>; from chrisl@gnuchina.org on Wed, Jun 19, 2002 at 01:03:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 19, 2002 at 01:03:38PM -0400, Christopher Li wrote:
 
> On Wed, 19 Jun 2002, Stephen C. Tweedie wrote:
> 
> > Hi,
> > 
> > On Tue, Jun 18, 2002 at 06:18:49PM -0400, Alexander Viro wrote:
> >  
> > > IOW, making sure that empty blocks in the end of directory get freed
> > > is a matter of 10-20 lines.  If you want such patch - just tell, it's
> > > half an hour of work...
> > 
> > It's certainly easier at the tail, but with htree we may have
> > genuinely enormous directories and being able to hole-punch arbitrary
> > coalesced blocks could be a huge win.  Also, doing the coalescing
> I would can contribute on that. I am thinking about it anyway.
> Daniel might already has some code there.
> 
> I have a silly question, where is that ext3 CVS? Under sourcefourge
> ext2/ext3 or gkernel?

cvs -d :ext:FOO@cvs.gkernel.sourceforge.net:/cvsroot/gkernel co ext3

The branches being used are

	cvs up -r ext3-1_0-branch	# HEAD of ext3 development
	cvs up -r features-branch	# For htree, ACLs etc

and there are a couple of other branches I use for tracking merges into
Linus's and the -ac trees.  The htree stuff is all that's new in the
features-branch right now.

Cheers,
 Stephen
