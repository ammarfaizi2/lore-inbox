Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbUJYR02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbUJYR02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbUJYR0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:26:24 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:13259 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261169AbUJYRQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:16:17 -0400
Date: Mon, 25 Oct 2004 13:16:04 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 8/28] VFS: Remove MNT_EXPIRE support
In-reply-to: <20041025150446.GB1603@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Message-id: <417D34D4.3040406@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <10987153211852@sun.com> <10987153522992@sun.com>
 <20041025150446.GB1603@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Mon, Oct 25, 2004 at 10:42:32AM -0400, Mike Waychison wrote:
> 
>>Drop support for MNT_EXPIRE (flag to umount(2)).  Nobody was using it and it
>>didn't fit into the new expiry framework.
> 
> 
> umm, this is a user API, you can't simply drop it.
> 

I also wanted to add that given the current interface that is found in
mainline, there is no way for userspace to even set a mountpoint as
expiring.  The only consumer is still AFS which handles the
mark_mounts_for_expiry stuff itself.

So even if userspace wanted to use MNT_EXPIRE, it couldn't.

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

iD8DBQFBfTTUdQs4kOxk3/MRAghsAJ41gA73Qov2lS6nHGcC+A3zsIc+DQCeIdCB
4XisV0zx/CvTDQpQfSfLY04=
=Qj2Q
-----END PGP SIGNATURE-----
