Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTJLVlf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 17:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTJLVlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 17:41:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261152AbTJLVle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 17:41:34 -0400
Date: Sun, 12 Oct 2003 22:41:33 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Valdis.Kletnieks@vt.edu
Cc: kevin conaway <kconaway_is@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Where does user_path_walk() live?
Message-ID: <20031012214133.GO7665@parcelfarce.linux.theplanet.co.uk>
References: <20031012202609.54340.qmail@web20422.mail.yahoo.com> <20031012203819.GN7665@parcelfarce.linux.theplanet.co.uk> <200310122059.h9CKxweb019804@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310122059.h9CKxweb019804@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 04:59:58PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 12 Oct 2003 21:38:19 BST, viro@parcelfarce.linux.theplanet.co.uk said:
> > On Sun, Oct 12, 2003 at 01:26:09PM -0700, kevin conaway wrote:
> > > I am a student doing an independent study on
> > > filesystem security and I was trying to pin down
> > 
> > man find
> > man xargs
> > man grep
> > 
> > RTFUnixFAQ
> 
> Actually, the answer Kevin wanted was:
> 
> cd /usr/src/linux
> grep -r __user_walk .

Ehh...  First of all, you'll end up doing a metric buttload of getdents()
for no good reason every time you want to search for something.  And on
the kernel source that's pretty noticable.

Moreover, you generally do *not* want to deal with every file in the tree -
find . -name *.[chS] does it nicely, grep -r can't do that at all.

grep -r is a pointless GNUism.  It's not safer than find + xargs grep, it's
weaker than use of find and it's non-portable to boot...
