Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271350AbTGWWNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271360AbTGWWNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:13:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:5650 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S271350AbTGWWNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:13:11 -0400
Date: Thu, 24 Jul 2003 00:27:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-ID: <20030723222747.GF643@alpha.home.local>
References: <200307232046.46990.bernie@develer.com> <20030723193246.GA836@lst.de> <200307232357.25128.bernie@develer.com> <200307240007.15377.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307240007.15377.bernie@develer.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Thu, Jul 24, 2003 at 12:07:15AM +0200, Bernardo Innocenti wrote:
 
>    text    data     bss     dec     hex filename
>  633028   37952  134260  805240   c4978 linux-2.4.x/linux-Os
>  819276   52460   78896  950632   e8168 linux-2.5.x/vmlinux-inline-Os
>  ^^^^^^
>        2.6 still needs a hard diet... :-/

I did the same observation a few weeks ago on 2.5.74/gcc-2.95.3. I tried
to track down the responsible, to the point that I completely disabled every
driver, networking option and file-system, just to see, and got about a 550 kB
vmlinux compiled with -Os. 550 kB for nothing :-(

I don't have the config nor the exact numbers right here now, but I can
redo the tests on 2.6.0-test1 if needed.

I was interested in using a very minimal pre-boot kernel with kexec which would
automatically select a valid image among several ones. But 500 kB overhead for
a boot loader quickly refrained me...

Cheers,
Willy

