Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWGaTZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWGaTZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWGaTZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:25:05 -0400
Received: from terminus.zytor.com ([192.83.249.54]:49322 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030346AbWGaTZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:25:01 -0400
Message-ID: <44CE58EE.1090409@zytor.com>
Date: Mon, 31 Jul 2006 12:24:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, stable@kernel.org, akpm@osdl.org,
       chrisw@sous-sol.org, grim@undead.cc, Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] initramfs:  Allow rootfs to use tmpfs instead of ramfs
References: <200607301808.14299.a1426z@gawab.com> <Pine.LNX.4.64.0607301750080.10648@blonde.wat.veritas.com> <44CCFF09.2000106@zytor.com> <200607310003.48637.a1426z@gawab.com>
In-Reply-To: <200607310003.48637.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
>>
>> The main issue -- which I am not sure what effect this patch has -- is
>> that we would really like to move initramfs initialization even earlier
>> in the kernel, so that it can include firmware loading for built-in
>> device drivers, for example.
> 
> I suspect, if there would be a problem with tmpfs, then ramfs would be no 
> different.
> 

That is a very bold assumption (a.k.a. "just plain wrong".)  ramfs and 
tmpfs are a lot more different than one would normally think from a 
kernel internals perspective.

>> Thus, if this patch makes it harder to push initramfs initialization
>> earlier, it's probably a bad thing.
> 
> Agreed, but remember that tmpfs is an option, not a replacement.

Red herring.  If it goes in, it needs to be supportable going forward.

>> If not, the author of the patch
>> really needs to explain why it works and why it doesn't add new
>> dependencies to the initialization order.
>>
>> Saying "this is a trivial patch" and pushing it on the -stable tree
>> doesn't inspire too much confidence, as initialization is subtle.
> 
> Ok, I did play with main.c, and as you mentioned, initialization is subtle.  
> But categorizing this patch as trivial is based more on the fact, that ramfs 
> and tmpfs are semantically equivalent, and as such should not impose 
> additional dependencies.

Again, that's just plain wrong.

	-hpa
