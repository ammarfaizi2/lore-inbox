Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268754AbUHZLxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268754AbUHZLxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUHZLsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:48:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4795 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268798AbUHZLpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:45:36 -0400
Date: Thu, 26 Aug 2004 07:42:48 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <200408261034.38509.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Denis Vlasenko wrote:

> > I like cat < a > b. You can keep your progress.
> 
> cat <a >b does not preserve following file properties even on standard
> UNIX filesystems: name,owner,group,permissions.

Losing permissions is one thing.  Annoying, mostly.

However, actual losing file data during such a copy is
nothing short of a disaster, IMHO.  

In my opinion we shouldn't merge file-as-a-directory
semantics into the kernel until we figure out how to
fix the backup/restore problem and keep standard unix
utilities work.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

