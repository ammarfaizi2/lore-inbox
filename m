Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbTIKOKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbTIKOKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:10:06 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:54694 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261167AbTIKOKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:10:01 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0
Date: Thu, 11 Sep 2003 16:11:28 +0200
User-Agent: KMail/1.5.3
References: <200309111540.58729@bilbo.math.uni-mannheim.de> <20030911134557.GV454@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030911134557.GV454@parcelfarce.linux.theplanet.co.uk>
Cc: viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111611.28198@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. September 2003 15:45 schrieben Sie:
> On Thu, Sep 11, 2003 at 03:40:58PM +0200, Rolf Eike Beer wrote:
> > Hi,
> >
> > a (very) simple grep in drivers/ showed more than 300 matches of code
> > like this:
> >
> > foo = kmalloc(bar, baz);
> > if (! foo)
> > 	return -ENOMEM;
> > memset(foo, 0, sizeof(foo));

> Erm.  It would better *not* be there in such amounts - sizeof(foo) would
> be a size of pointer...

Eek, yes. Typo from me.

> > Why not add a small inlined function doing the memset for us
> > and reducing the code to
> >
> > foo = kmalloc0(bar, baz);
> > if (! foo)
> > 	return -ENOMEM;
>
> Bad choice of name - too easy to confuse with kmalloc().

Yes, maybe. But don't expect more innovations from me today, it's someone 
else's turn ;)

Eike
