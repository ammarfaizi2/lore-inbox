Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269137AbUHZQCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269137AbUHZQCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269132AbUHZQCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:02:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29666 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269083AbUHZQB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:01:28 -0400
Date: Thu, 26 Aug 2004 11:54:51 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jamie Lokier <jamie@shareable.org>
cc: Christophe Saout <christophe@saout.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>,
       <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826154446.GG5733@mail.shareable.org>
Message-ID: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Jamie Lokier wrote:
> Christophe Saout wrote:

> > And if you read test.compound (the main stream) you get a special format
> > that contains all the components. You can copy that single stream of
> > bytes to another (reiser4) fs and then access test.compound/test.txt
> > again.
> 
> (To Rik especially), this is the design which more or less satisfies
> lots of different goals at once.

And if an unaware application reads the compound file
and then writes it out again, does the filesystem
interpret the contents and create the other streams ?

Unless I overlook something (please tell me what), the
scheme just proposed requires filesystems to look at
the content of files that is being written out, in
order to make the streams work.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


