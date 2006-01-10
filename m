Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWAJQk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWAJQk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWAJQk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:40:26 -0500
Received: from rtr.ca ([64.26.128.89]:26797 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751152AbWAJQkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:40:25 -0500
Message-ID: <43C3E376.3020303@rtr.ca>
Date: Tue, 10 Jan 2006 11:40:22 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
...
> Can we do one final cleanup? Do all the magic in _one_ place, namely the 
> x86 Kconfig file.
...
> 		config DEFAULT_3G
> 			bool "3G/1G user/kernel split"
> 		config DEFAULT_3G_OPT
> 			bool "3G/1G user/kernel split (for full 1G low memory)"
> 		config DEFAULT_2G
> 			bool "2G/2G user/kernel split"
> 		config DEFAULT_1G
> 			bool "1G/3G user/kernel split"
...

Are "DEFAULT_*" really the best names to assign to these options?
For these options, I'd expect something like "VMUSER_*" or "USERMEM_*".

Cheers
