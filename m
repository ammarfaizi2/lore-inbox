Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVAYX7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVAYX7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVAYX6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:58:46 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:38055 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262249AbVAYX5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:57:15 -0500
Date: Tue, 25 Jan 2005 18:56:51 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <20050125215511.GD21764@fieldses.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Ram <linuxram@us.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <41F6DCC3.5040002@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <20050116160213.GB13624@fieldses.org>
 <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
 <20050116184209.GD13624@fieldses.org>
 <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
 <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost>
 <41F6BE58.50208@sun.com> <20050125215511.GD21764@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

J. Bruce Fields wrote:
> On Tue, Jan 25, 2005 at 04:47:04PM -0500, Mike Waychison wrote:
> 
>>Although Al hasn't explicitly defined the semantics for mount
>>- --make-shared, I think the idea is that 'only' that mountpoint becomes
>>tagged as shared (becomes a member of a p-node of size 1).
> 
> 
> On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
> 
>>	* we can mark a subtree sharable.  Every vfsmount in the subtree
>>that is not already in some p-node gets a single-element p-node of its
>>own.
> 
> 
> Also, note that mount automatically sets up propagation that mirrors
> that of the mounted on vfsmount, so by default new mounts anywhere in
> the subtree will also be tagged as shared.
> 

Why not simply call this --make-rshared and keep --make-shared only
share a single mount then?

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

iD8DBQFB9tzDdQs4kOxk3/MRAp3jAJ9CjPjEQs1jvcm92Q2jAizYvnBOSgCeJ9A0
Jt0d1v7iLB3EPbEWq9r6zik=
=3u5S
-----END PGP SIGNATURE-----
