Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbUCTKVK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbUCTKVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:21:10 -0500
Received: from mail.shareable.org ([81.29.64.88]:8335 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263322AbUCTKVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:21:05 -0500
Date: Sat, 20 Mar 2004 10:20:54 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Peter Zaitsev <peter@mysql.com>
Cc: reiser@namesys.com, Chris Mason <mason@suse.com>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040320102054.GB10398@mail.shareable.org>
References: <1079641026.2447.327.camel@abyss.local> <1079642001.11057.7.camel@watt.suse.com> <1079642801.2447.369.camel@abyss.local> <1079643740.11057.16.camel@watt.suse.com> <1079644190.2450.405.camel@abyss.local> <1079644743.11055.26.camel@watt.suse.com> <405AA9D9.40109@namesys.com> <1079704347.11057.130.camel@watt.suse.com> <405B4BA3.2030205@namesys.com> <1079726769.2446.233.camel@abyss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079726769.2446.233.camel@abyss.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:
> If file system would guaranty atomicity of write() calls (synchronous
> would be enough) we could disable it and get good extra performance.

Store an MD5 or SHA digest of the page in the page itself, or elsewhere.
(Obviously the digest doesn't include the bytes used to store it).

Then partial write errors are always detectable, even if there's a
hardware failure, so journal writes are effectively atomic.

-- Jamie
