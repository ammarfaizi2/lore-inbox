Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWAWUsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWAWUsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWAWUsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:48:46 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:57507 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932472AbWAWUsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:48:32 -0500
Date: Mon, 23 Jan 2006 21:48:30 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060123204830.GF10077@vanheusden.com>
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org>
	<43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org>
	<4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com>
	<20060123072447.GA8785@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123072447.GA8785@thunk.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Jan 24 20:23:13 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You could of course design a filesystem which maintained a reverse map
> data structure, but it would slow the filesystem down since it would
> be a separate data structure that would have to be updated each time
> you allocated or freed a disk block.  And the only use for such a data
> structure would be to make shrinking a filesystem more efficient.
> Given that this is generally not a common operation, it seems unlikely
> that a filesystem designer would choose to make this particular
> tradeoff.

Or you could set if switched off by default. E.g. reserve the space for
it and activate it as soon as some magic switch is set in the kernel.
Then some background processs should update it while als keeping track
of current changes. Then when everything is finished, update some flag
to let the resizer know it can do its job.


Folkert van Heusden

-- 
www.vanheusden.com/recoverdm/ - got an unreadable cd with scratches?
                            recoverdm might help you recovering data
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
