Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWAJOJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWAJOJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWAJOJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:09:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:25572 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751003AbWAJOJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:09:58 -0500
Message-ID: <43C3C023.9040308@suse.de>
Date: Tue, 10 Jan 2006 15:09:39 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <17347.47882.735057.154898@alkaid.it.uu.se> <20060110135404.GF3389@suse.de>
In-Reply-To: <20060110135404.GF3389@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi,

> 0xb0000000 is a much better default, but I didn't think that would fly
> as a patch.

I think that will not fly with CONFIG_X86_PAE.  In PAE mode the 3rd pmd 
  (for the 0xc0000000 => 0xffffffff kernel address range) is shared, 
anything but 0xc000000 most likely needs some more hackery than just 
changing PAGE_OFFSET.  As the whole point of this split patchery is to 
avoid highmem in the first place it maybe makes sense to have some 
"optimize for 1/2/4/more GB main memory" config option which in turn 
picks sane PAGE_OFFSET+HIGHMEM+PAE settings?

cheers,

   Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
