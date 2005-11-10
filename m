Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVKJVIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVKJVIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVKJVIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:08:54 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:9990 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932146AbVKJVIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:08:53 -0500
Date: Thu, 10 Nov 2005 22:09:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bruce Korb <bruce.korb@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: missing build functionality?
Message-ID: <20051110210956.GD7584@mars.ravnborg.org>
References: <200411232102.iANL2H5T025781@turing-police.cc.vt.edu> <200511100807.53219.bruce.korb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511100807.53219.bruce.korb@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> So, it would still be very useful to know how to link against a "libmumble.a"
> file built in another directory.
You can specify a .o file in another directory. Do you really need a .a
file? oprofile for ones does this. xfs is another example.

> Copying all sources and libraries into
> a build directory before kicking off the build is kludgey.  (Linux being the
> only platform where that seems to be necessary.)
Assuming you are talking about the kernel then the kernel build system
is optimised for buiding the kernel.
And the kernel source keep relevant files together as much as possible.
See for example drivers/net. A lot of files, but most of them is a net
driver so no value gained introducing a directory for a simple driver.

And experience has shown that usage of libaries has resulted in more
problems than it has solved in most cases. Thats why libraries are so
seldom used in the kernel.
When do you need to include crc32.o in the kernel for instance.


	Sam
