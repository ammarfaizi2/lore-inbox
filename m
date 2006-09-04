Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWIDNs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWIDNs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWIDNs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:48:29 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:15582 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964803AbWIDNs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:48:28 -0400
Date: Mon, 4 Sep 2006 07:48:27 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Sukadev Bhattiprolu <sukadev@us.ibm.com>,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] 2.6.18-rc5-mm1: is_init() parisc compile error
Message-ID: <20060904134826.GF2558@parisc-linux.org>
References: <20060901015818.42767813.akpm@osdl.org> <20060904114130.GN4416@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060904114130.GN4416@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 01:41:30PM +0200, Adrian Bunk wrote:
> pidspace-is_init.patch causes the following compile error on parisc:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/parisc/kernel/module.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/parisc/kernel/module.c:76: error: conflicting types for 'is_init'
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/sched.h:1090: error: previous definition of 'is_init' was here
> make[2]: *** [arch/parisc/kernel/module.o] Error 1
> 
> <--  snip  -->

Looks like ia64 calls the same function in_init().  I'm tempted to
change parisc to have the same name.
