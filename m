Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVJFJQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVJFJQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVJFJQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:16:55 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:28088 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750756AbVJFJQz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:16:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tLxYd1EpQkcDx+buJ3JRxcN6mfYVGAq+QThbo9sKk2Mo1k2kuUgJ1j6ylokqox1rt/4c0ojgbE1FlmT5+SYhPOGCAa7Re4yleI/j0WTSKNDAOxk6tC++RLpsZBj6FuVrm49/dxX2MNBC/Qhl/+SOl2sZ4swu6rPaS11h2GcW7xg=
Message-ID: <309a667c0510060216q315d55b0n4a6934d168ebccfb@mail.gmail.com>
Date: Thu, 6 Oct 2005 14:46:54 +0530
From: devesh sharma <devesh28@gmail.com>
Reply-To: devesh sharma <devesh28@gmail.com>
To: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: [NUMA x86_64] problem accessing global Node List pgdat_list
In-Reply-To: <309a667c0510050550x68e0c996q51e00e908813b5c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <309a667c0510042240y1dcc75c4l83abc7fe430e4f05@mail.gmail.com>
	 <4343CA4F.8030003@cosmosbay.com>
	 <309a667c0510050550x68e0c996q51e00e908813b5c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,
I have tried numa=fake=4 on intel xeon with 2.6.13 kernel it is
working fine and by adding EXPORT_SYMBOL(pgdat_list)  in
mm/page_alloc.c now I am able to access pgdat_list also. But on
opteron machine there is some problem in kernel compilation
at make install stage I am getting following warning

WARNING: No module mptbase found for kernel 2.6.13, continuing anyway
WARNING: No module mptscsih found for kernel 2.6.13, continuing anyway

now when I boot my kernel, panic is received

Booting the kernel.
Red Hat nash version 4.1.18 starting
mkrootdev: lable / not found
mount: error 2 mounting ext3
mount: error 2 mounting none
switchroot: mount failed : 22
umount : /initrd/dev failed : 22
kernel panic - not syncing : Attempted to kill init

On the other hand when I complie same source code on XEON machine this
works fine.

what could be the problem?
