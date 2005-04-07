Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVDGSZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVDGSZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVDGSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:25:57 -0400
Received: from smtp.istop.com ([66.11.167.126]:9187 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262501AbVDGSZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:25:50 -0400
From: Daniel Phillips <phillips@istop.com>
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Kernel SCM saga..
Date: Thu, 7 Apr 2005 14:27:03 -0400
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <Pine.LNX.4.58.0504071038320.28951@ppc970.osdl.org> <20050407180412.GA31861@wohnheim.fh-wedel.de>
In-Reply-To: <20050407180412.GA31861@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200504071427.04162.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 April 2005 14:04, Jörn Engel wrote:
> On Thu, 7 April 2005 10:47:18 -0700, Linus Torvalds wrote:
>> ... There should be some support for cherry-picking in between
> > a temporary throw-away tree and a "cleaned-up-tree". However, it should
> > be something you really do need to think about, and in most cases it
> > really does boil down to "export as patch, re-import from patch".
> > Especially since you potentially want to edit things in between anyway
> > when you cherry-pick.
>
> For reordering, using patcher, you can simply edit the sequence file
> and move lines around.  Nice and simple interface.
>
> There is no checking involved, though.  If you mode dependent patches,
> you end up with a mess and either throw it all away or seriously
> scratch your head.  So a serious SCM might do something like this:
>
> $ cp series new_series
> $ vi new_series
> $ SCM --reorder new_series
>   # essentially "mv new_series series", if no checks fail
>
> Merging patches isn't that hard either.  Splitting them would remain
> manual, as you described it.

Well it's clear that adding cherry picking, patch reordering, splitting and 
merging (two patches into one) is not even hard, it's just a matter of making 
it convenient by _building it into the tool_.  Now, can we just pick a tool 
and do it, please?  :-)

Regards,

Daniel
