Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271702AbTG2NAE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271705AbTG2NAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:00:04 -0400
Received: from dialpool-210-214-82-140.maa.sify.net ([210.214.82.140]:37769
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S271702AbTG2NAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:00:00 -0400
Date: Tue, 29 Jul 2003 18:30:58 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
Message-ID: <20030729130058.GA3636@localhost.localdomain>
References: <20030728225947.GA1694@localhost.localdomain> <20030729014822.6488539d.akpm@osdl.org> <20030729105706.GA2761@localhost.localdomain> <20030729114838.GS150921@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729114838.GS150921@niksula.cs.hut.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 02:48:38PM +0300, Ville Herva wrote:
> On Tue, Jul 29, 2003 at 04:27:06PM +0530, you [Balram Adlakha] wrote:
> > On Tue, Jul 29, 2003 at 01:48:22AM -0700, Andrew Morton wrote:
> > > Balram Adlakha <b_adlakha@softhome.net> wrote:
> > > >
> > > > I cannot transfer files larger than 914 mb from an NFS mounted
> > > > filesystem to a local filesystem. A larger file than that is
> > > > simply cut of at 914 MB. This is using 2.6.0-test1, 2.4.20 
> > > > works fine. Can it be the version of mount I'm using? Its the
> > > > one that comes with util-linux-2.11y.
> > > 
> > > Works OK here, with `cp'.  How are you "transferring" the file?
> > > 
> > > You're sure there is sufficient disk space on the receiving end? (sorry)
> > > 
> > > Can you strace the copy operation, see why it terminates?
> > 
> > Very strange, It was a 4.9 GB raw mpeg-ps file and I couldn't copy more than 914 mb of it using -test2, even playing the file from the server using mplayer didn't work (and I wasn't smart enough to use strace) then I rebooted with 2.4.20 and the whole file was copied. Now I tried copying a 990 mb wav file and it worked(using -test2). The orginal 4.9 GB file is not on the server now so I'll have to put it there first and then copy it again. It'll take some time on my slow NIC (and the server being a 300 Mhz laptop). I'll email you again, sorry.
> 
> Rather than copying a file over, you can create a sparse file very quickly:
> 
>   touch foo; perl -e 'truncate "foo", 2000000000'
> 
> (creates a 2000000000 byte sparse file). Neat thing is, sparse files don't
> take disk space on the server.
> 
> Or if you prefer a non-sparse file: 
> 
>   head -c 2000m /dev/zero > foo
> 
> 
> -- v --
> 
> v@iki.fi

Availablity of files is not a problem, theres already a large number of large files that I want to transfer to and from my computer. I didn't know about sparse files, will my NIC be used the same way?
