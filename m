Return-Path: <linux-kernel-owner+w=401wt.eu-S1762271AbWLKVQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762271AbWLKVQR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761865AbWLKVQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:16:16 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35125 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762257AbWLKVQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:16:16 -0500
Message-ID: <457DCA58.7080902@zytor.com>
Date: Mon, 11 Dec 2006 13:15:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Olaf Hering <olaf@aepfle.de>, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
>  - strongly encourage "get_kernel_version" users to just stop using that 
>    crap. Ask the build system for the version instead or something, don't 
>    expect to dig it out of the binary (if you create an RPM for any other 
>    package, you sure as _hell_ don't start doing strings on the binary and 
>    try to figure out what the kernel is - you do it as part of the build)
> 

This is (presumably) not just "strings" on the binary -- it's actually 
using the documented way to statically extract a version number string 
from a Linux kernel binary, even a compressed one.  A lot of things, 
including Grub, depends on it.  If they're doing something other than 
that, of course, then they deserve what they get.

Now, their problem is that they're making assumptions that are probably 
unwarranted about the contents of that string.

	-hpa
