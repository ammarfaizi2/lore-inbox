Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWGNRuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWGNRuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbWGNRuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:50:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:59295 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422672AbWGNRt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:49:59 -0400
Message-ID: <44B7D97B.20708@suse.com>
Date: Fri, 14 Jul 2006 13:50:51 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: 7eggert@gmx.de
Cc: Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz>
In-Reply-To: <E1G1QFx-0001IO-K6@be1.lrz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bodo Eggert wrote:
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>> On Wednesday 12 July 2006 18:42, Jeff Mahoney wrote:
> 
>>>  On systems with block devices containing slashes (virtual dasd, cciss,
>>>  etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
>>>  it being interpreted as a subdirectory. The generic block device code
>>>  changes the / to ! for use in the sysfs tree. This patch uses that
>>>  convention.
>>>
>>>  Tested by making dm devices use dm/<number> rather than dm-<number>
>> Your patch handles at most one slash. But the description mentions 'slashes'
>> (ie several slashes)
> 
> Besides that, there is no reason to prevent the user from using many slashes.
> OTOH, I'd prefer propper quoting, but having each driver do this would be
> insane.

The strings aren't user-supplied, they're kernel-internal names of block
devices, supplied by the driver. At present there is no possibility of
more than one slash in the name, and I doubt we'll see any new devices
with one slash in them, never mind more than one.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEt9l6LPWxlyuTD7IRAgwsAJ9nvPJRnnJsbqukhtJj3T2mjJC1hQCfYYeh
lbTYktc+yglYRmxT/LwPcT4=
=767A
-----END PGP SIGNATURE-----
