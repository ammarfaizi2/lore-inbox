Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUDCNPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 08:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUDCNPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 08:15:52 -0500
Received: from mail.shareable.org ([81.29.64.88]:41878 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261741AbUDCNPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 08:15:51 -0500
Date: Sat, 3 Apr 2004 14:15:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403131539.GA4706@mail.shareable.org>
References: <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <406DE280.6050109@nortelnetworks.com> <20040403004947.GI653@mail.shareable.org> <20040403082303.GA1316@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403082303.GA1316@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > > Could you not change it back to a normal inode when refcount becomes 1? 
> > 
> > You can only do that if the cowid object has a pointer to the last
> > remaining reference to it.  That's possible, but more complicated and
> > would incur a little more I/O per cow operation.
> 
> You'd have to have pointers to all references to it... because you
> can't tell in advance which one will be the last to go away.

Exactly.  Each of the cow pointers would need to be linked in a doubly
linked list containing them all.

-- Jamie
