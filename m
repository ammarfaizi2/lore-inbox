Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbSJQVnK>; Thu, 17 Oct 2002 17:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbSJQVnJ>; Thu, 17 Oct 2002 17:43:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65213 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262196AbSJQVnI>;
	Thu, 17 Oct 2002 17:43:08 -0400
Date: Thu, 17 Oct 2002 17:49:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Russell Coker <russell@coker.com.au>
cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <200210172337.49463.russell@coker.com.au>
Message-ID: <Pine.GSO.4.21.0210171742050.18575-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Oct 2002, Russell Coker wrote:

> > What specific information differs per-operation, such that security
> > identifiers cannot be stored internally inside a file handle?
> 
> My previous message obviously wasn't clear enough.
> 
> When you want to read or set the SID of a file handle then you need to pass in 
> a SID pointer or a SID.

So fscking what?  _Nothing_ of the above warrants a new syscall.  There
are struct file * attributes and there are descriptor attributes.
Rather than excreting a new syscall you could look what already exists
in the API.

Frankly, SELinux has some interesting ideas, but interfaces are appalling.
Either they've never cared about it, or they have no taste (or have, er,
overriding manag^Wissues actively hostile to any taste).  Take your pick.

And don't get me started on access to file by inumber and other beauties
in that excuse of an API.  It wasn't designed.  It happened.  As in, "it
happens".

