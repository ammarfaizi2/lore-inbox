Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUIADLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUIADLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 23:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268972AbUIADLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 23:11:44 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:24593 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S268971AbUIADLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 23:11:42 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Spam <spam@tnonline.net>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
Date: Wed, 1 Sep 2004 05:11:31 +0200
User-Agent: KMail/1.6.1
Cc: Tonnerre <tonnerre@thundrix.ch>, V13 <v13@priest.com>,
       Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, <reiserfs-list@namesys.com>
References: <41323AD8.7040103@namesys.com> <20040831190814.GA15493@thundrix.ch> <111617109.20040831213808@tnonline.net>
In-Reply-To: <111617109.20040831213808@tnonline.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200409010511.31597.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 21.38, Spam wrote:
> > Salut,
> >
> > On Tue, Aug 31, 2004 at 08:17:36PM +0200, Spam wrote:
> >>   How  are  things  done on Windows platforms when there are files and
> >>   directories  with the same name? In Unix that is imposible. How does
> >>   it  work  for  environments  like  Cygwin  etc? What happen to tools
> >>   that run in them?
> >
> > In  NTFS it's  illegal  IIRC.  At least  the  fs correction  utilities
> > complain about a block being assigned to two files.
>
>   I  meant  a  file  and a directory with the same name, not two files
>   with the same name :) subtle but important difference.
>
>   ie,  you can have a file named "foo" and a directory named "foo" and
>   they won't collide.

You can't have a file and a directory with the same name in W*.

Alternative data streams don't appear in a normal directory. You
need special API:s and tools to see them. If you know the name of and ADS
you can however access them with standard tools, including cygwin.

echo foo >a.txt
echo bar >a.txt:b.txt

You can also have ADS's on directories. Not sure how Reiserfs4 does that.

mkdir foo
echo bar >foo:a.txt

-- robin
