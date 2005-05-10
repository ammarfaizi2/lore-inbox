Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVEJPkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVEJPkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVEJPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:39:22 -0400
Received: from smtp.e7even.com ([83.151.192.5]:31892 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S261698AbVEJPiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:38:55 -0400
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Hans Reiser <reiser@namesys.com>, sean.mcgrath@propylon.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <200505101514.j4AFEhGO010837@turing-police.cc.vt.edu>
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>
	 <41A23496.505@namesys.com> <1101287762.1267.41.camel@pear.st-and.ac.uk>
	 <1115717961.3711.56.camel@grape.st-and.ac.uk>
	 <200505101514.j4AFEhGO010837@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1115739527.3711.124.camel@grape.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 May 2005 16:38:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 16:14, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 10 May 2005 10:39:23 BST, Peter Foldiak said:
> > Back in November 2004, I suggested on the linux-kernel and reiserfs
> > lists that the Reiser4 architecture could allow us to abolish the
> > unnatural naming distinction between directories/files/parts-of-file
> > (i.e. to unify naming within-file-system and within-file naming) in an
> > efficient way.
> > I suggested that one way of doing that would be to extend XPath-like
> > selection syntax above the (XML) file level.
> 
> I believe the consensus was that this needs to happen at the VFS layer, not
> the FS level.  The next step would be designing an API for this - what would
> the VFS present to userspace, and in what way, and how would backward
> combatability be maintained?

But can it be done efficiently above the file system level??

As far as I understand, Reiser4 has this nice tree structure, which
means that the part of file selection could be done with almost no extra
effort, you just attach additional names to inside nodes of the tree, so
the same tree can be used to store the whole object, and part of the
same tree can be used to select the object part. Right?
If you do this above the file system level, I don't think it would have
such an efficient implementation. Or would it?  Peter

