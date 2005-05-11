Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVEKKSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVEKKSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVEKKSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:18:45 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:42511 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261201AbVEKKSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:18:43 -0400
Date: Wed, 11 May 2005 12:23:44 +0200
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
Cc: Valdis.Kletnieks@vt.edu, Hans Reiser <reiser@namesys.com>,
       sean.mcgrath@propylon.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: file as a directory
Message-ID: <20050511102344.GA8277@hh.idb.hist.no>
References: <2c59f00304112205546349e88e@mail.gmail.com> <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com> <41A23496.505@namesys.com> <1101287762.1267.41.camel@pear.st-and.ac.uk> <1115717961.3711.56.camel@grape.st-and.ac.uk> <200505101514.j4AFEhGO010837@turing-police.cc.vt.edu> <1115739527.3711.124.camel@grape.st-and.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115739527.3711.124.camel@grape.st-and.ac.uk>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 04:38:48PM +0100, Peter Foldiak wrote:
> On Tue, 2005-05-10 at 16:14, Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 10 May 2005 10:39:23 BST, Peter Foldiak said:
> > > Back in November 2004, I suggested on the linux-kernel and reiserfs
> > > lists that the Reiser4 architecture could allow us to abolish the
> > > unnatural naming distinction between directories/files/parts-of-file
> > > (i.e. to unify naming within-file-system and within-file naming) in an
> > > efficient way.
> > > I suggested that one way of doing that would be to extend XPath-like
> > > selection syntax above the (XML) file level.
> > 
> > I believe the consensus was that this needs to happen at the VFS layer, not
> > the FS level.  The next step would be designing an API for this - what would
> > the VFS present to userspace, and in what way, and how would backward
> > combatability be maintained?
> 
> But can it be done efficiently above the file system level??
> 
Anything that can be done at the fs level should be doable on the vfs level too.
That is simple to show in theory: You could make the VFS api identical to
the reiser4 api, and reiser4 should continue to work as efficiently as before.

> As far as I understand, Reiser4 has this nice tree structure, which
> means that the part of file selection could be done with almost no extra
> effort, you just attach additional names to inside nodes of the tree, so
> the same tree can be used to store the whole object, and part of the
> same tree can be used to select the object part. Right?
> If you do this above the file system level, I don't think it would have
> such an efficient implementation. Or would it?  Peter

I cannot see why reiser4 should suffer - but of course this might be hard to
implement for other filesystems.

Helge Hafting
