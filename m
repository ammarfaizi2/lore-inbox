Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVDGSEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVDGSEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVDGSEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:04:21 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:37568 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262541AbVDGSEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:04:12 -0400
Date: Thu, 7 Apr 2005 20:04:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050407180412.GA31861@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org> <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0504071038320.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0504071038320.28951@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 April 2005 10:47:18 -0700, Linus Torvalds wrote:
> On Thu, 7 Apr 2005, Al Viro wrote:
> > 
> > No.  There's another reason - when you are cherry-picking and reordering
> > *your* *own* *patches*.
> 
> Yes. I agree. There should be some support for cherry-picking in between a
> temporary throw-away tree and a "cleaned-up-tree". However, it should be
> something you really do need to think about, and in most cases it really
> does boil down to "export as patch, re-import from patch". Especially
> since you potentially want to edit things in between anyway when you
> cherry-pick.

For reordering, using patcher, you can simply edit the sequence file
and move lines around.  Nice and simple interface.

There is no checking involved, though.  If you mode dependent patches,
you end up with a mess and either throw it all away or seriously
scratch your head.  So a serious SCM might do something like this:

$ cp series new_series
$ vi new_series
$ SCM --reorder new_series
  # essentially "mv new_series series", if no checks fail

Merging patches isn't that hard either.  Splitting them would remain
manual, as you described it.

> Btw, this method of cherry-picking again requires two _separate_ active 
> trees at the same time. BK is great at that, and really, that's what 
> distributed SCM's should be all about anyway. It's not just distributed 
> between different machines, it's literally distributed even on the same 
> machine, and it's actively _used_ that way.

Amen!

Jörn

-- 
He who knows that enough is enough will always have enough.
-- Lao Tsu
