Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbUCEL2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 06:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbUCEL2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 06:28:34 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:57564 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262479AbUCEL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 06:28:33 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Date: Fri, 5 Mar 2004 22:28:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16456.25687.143806.508619@notabene.cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, obelix123@toughguy.net
Subject: Re: [TRIVIAL][PATCH]:/proc/fs/nfsd/
In-Reply-To: message from Petr Vandrovec on Friday March 5
References: <16B99F21693@vcnet.vc.cvut.cz>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 5, VANDROVE@vc.cvut.cz wrote:
> On  5 Mar 04 at 21:08, Neil Brown wrote:
> > > The following patch fixes it.
> > 
> > Does it need fixing??
> > 
> > If you remove this, then people who compile a kernel without nfsd
> > support, and then later decide to compile an nfsd module and load it,
> > will not be able to mount the nfsd filesystem at the right place.
> 
> > I think it is a very small cost, and a measurable gain, to leave it
> > there.
> 
> Maybe I'm stupid, but why cannot knfsd module create fs/nfsd
> directory at module load? That way you can do insmod/modprobe followed 
> by mount() to do that. And if you'll fiddle with do_mount a bit
> (so that get_fs_type() is invoked before walking mount path)
> you can do it even without modprobing knfsd in advance, by just
> doing 'mount none /proc/fs/nfsd -t nfsd'.
>                                                 Petr Vandrovec

I wanted 
   mount -t nfsd nfsd /proc/fs/nfsd
to load the module and, as you have noticed, that doesn't work.

"fiddle"ing with do_mount is an interesting idea.  If you (or someone)
can make that work and get it accepted, I am happy to have the nfsd
module create the directory.

NeilBrown
