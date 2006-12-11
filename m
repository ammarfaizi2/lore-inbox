Return-Path: <linux-kernel-owner+w=401wt.eu-S1762369AbWLKVU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762369AbWLKVU4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762594AbWLKVU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:20:56 -0500
Received: from terminus.zytor.com ([192.83.249.54]:51727 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762369AbWLKVU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:20:56 -0500
Message-ID: <457DCAA1.7000705@zytor.com>
Date: Mon, 11 Dec 2006 13:16:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Andy Whitcroft <apw@shadowen.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org> <457DAF99.4050106@shadowen.org> <20061211201552.GB20960@thunk.org>
In-Reply-To: <20061211201552.GB20960@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> 
> As far as whether or not it should be _mandatory_, to be able to pull
> out the version information from an arbitrary bzImage file, can folks
> agree that it would at least be a nice-to-have feature?  Sometimes
> when you're out in the field you don't know what you're faced with,
> especially if you're dealing with a customer who likes to build their
> own kernels, and who might not have, ah, a very well defined release
> process.  Sure, you can _call_ them incompetent, and it might even be
> true, but wouldn't be nice if there was an easy way to look at a
> bzImage file and be able to tell what kernel version it was built
> from?
> 

There is a documented procedure for doing exactly that.

See Documentation/i386/boot.txt for details; there is a pointer in the 
header which points to a cleartext string, even if the kernel is compressed.

	-hpa
