Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUIJSKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUIJSKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUIJSKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:10:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:62129 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267664AbUIJSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:10:19 -0400
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
	the idea ofwhat reiser4 wants to do with metafiles and why
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Paul Jakma <paul@clubi.ie>, "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4141E8DD.8050700@namesys.com>
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com>
	 <Pine.LNX.4.58.0409071658120.2985@sparrow>
	 <200409080009.52683.robin.rosenberg.lists@dewire.com>
	 <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com>
	 <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org>
	 <4140FBE7.6020704@namesys.com>
	 <Pine.LNX.4.61.0409100212080.23011@fogarty.jakma.org>
	 <414135E6.8050103@namesys.com>
	 <1094808053.17029.8.camel@localhost.localdomain>
	 <4141E8DD.8050700@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094836040.17990.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 18:07:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 18:48, Hans Reiser wrote:
> Is there a technical basis for your claim that we have trouble with disk 
> errors?
> 
> Do you mean badblocks support or what?

I mean probability of gettng your data back after a disk loses data. And
the technical basis for my claims is twofold - painful experience is
one, and shooting random blocks of zeros onto a disk and run fsck tools
is another. 

> I think it would be reasonable for people to say that our approach 
> currently has bugs, we should turn metafiles off until we make the bugs 
> go away.

Well reiserfs4 is a lot more than metafiles and new vfs layer concepts.
Clearly those parts of the the fs that don't require core fs changes
belong in the kernel as soon as everyone is happy they are clean enough
and look correct.

Metafiles and openat() are an argument we can all have later.

