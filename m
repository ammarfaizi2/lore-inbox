Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWEOKMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWEOKMV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWEOKMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:12:21 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:62856 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932364AbWEOKMT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:12:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jh5zDRYpdPFBxFwv9EJrDhYSEjpXC7yMBu4M/63FRMKwpkd/56dik3zr9fquHynEyqdTTm9R7VSEEwH6Jvfl4JXYTpqyj3tQfec4QDKjUJj80sUz1njQ9osvBzWDfPSx6tCUGSSJ/CJguWFDvb0C3Cskc+ak+jXQZlatShVq9pY=
Message-ID: <b0943d9e0605150312m22559450p28c44a17d88b6325@mail.gmail.com>
Date: Mon, 15 May 2006 11:12:18 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Oeser" <ioe-lkml@rameria.de>
Subject: Re: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <200605141939.51288.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <84144f020605140755w4c64dc14o8beda9f5bbb68b9c@mail.gmail.com>
	 <44674F17.2050606@gmail.com> <200605141939.51288.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/06, Ingo Oeser <ioe-lkml@rameria.de> wrote:
> While we are at it: How do you handle the encoding of
> info into the lower bits of a pointer? For Boehm GC,
> this was a major problem, AFAIR. At least the RT-Mutex code
> does this. There are others, but I'm to lazy to grep now...

I haven't looked at RT-Mutex but are more than the 2 bottom bits used
for this? If not, they can be masked out before look-up. The slab
allocator seems to always return blocks aligned to word size.

Thanks for pointing out.

-- 
Catalin
