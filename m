Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVBBVf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVBBVf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbVBBVfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:35:02 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:56477 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262797AbVBBVdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:33:51 -0500
Date: Wed, 02 Feb 2005 16:33:08 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <20050202212557.GC3879@fieldses.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Ram <linuxram@us.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <42014714.2070901@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
 <20050116184209.GD13624@fieldses.org>
 <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
 <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost>
 <20050201232106.GA22118@fieldses.org> <1107369381.5992.73.camel@localhost>
 <42012DE7.4080003@sun.com> <1107376434.5992.113.camel@localhost>
 <42014150.9090500@sun.com> <20050202212557.GC3879@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

J. Bruce Fields wrote:
> On Wed, Feb 02, 2005 at 04:08:32PM -0500, Mike Waychison wrote:
> 
>>Well, fwiw, I have the same kind of race in autofsng.  I counter it by
>>building up the vfsmount tree elsewhere and mount --move'ing it.
>>
>>Unfortunately, the RFC states that moving a shared vfsmount is
>>prohibited (for which the reasoning slips my mind).
> 
> 
> See http://marc.theaimsgroup.com/?l=linux-fsdevel&m=110594248826226&w=2
> 
> As I understand it, the problem isn't sharing of the vfsmount being
> moved, but sharing of the vfsmount on which that vfsmount is
> mounted.--b.

Okay, thanks for the refresher.

That still keeps you from using the 'build tree elsewhere' and 'mount
- --move' approach though, as the parent mountpoint would likely be shared.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCAUcUdQs4kOxk3/MRAubGAJ0fUrpVS9U5oQof5jv4JieVOo6JjwCgjHXa
oHcjXLEV5zj4OrB+TEipQdY=
=3hhk
-----END PGP SIGNATURE-----
