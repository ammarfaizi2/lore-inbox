Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbVHXUEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbVHXUEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbVHXUEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:04:08 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:28690 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751527AbVHXUEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:04:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=V47uG8YtJ8xdsikSy8f+RojW6Fk80m8bo5+kJelCVL8sVjTbudWfdT1OoRCAPls61iyRAn5/OiwmtiAfgcdcxLYslVW0OsKuav2AthuribtSC7FmKdpOEvFh8hbJ9MKdg2c7sjrtykGag8neuGF9zc4QPADmujivb65mtHHQvrg=
Date: Thu, 25 Aug 2005 00:13:02 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Paul Jackson <pj@sgi.com>, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050824201301.GA23715@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 08:15:44PM +0100, Al Viro wrote:
> Most of the remaining stuff is for
> m68k (and applies both to Linus' tree and m68k CVS); I'll send that today
> and if Geert ACKs them, we will be _very_ close to having 2.6.13 build
> out of the box on the following set:
> alpha,

Do I understand correctly that alpha in "--><-- close" list?

2.6.13-rc7, alpha, allmodconfig:

  LD      .tmp_vmlinux1
net/built-in.o: In function `kmalloc':
include/linux/slab.h:92: undefined reference to `__you_cannot_kmalloc_that_much'
include/linux/slab.h:92: undefined reference to `__you_cannot_kmalloc_that_much'

Guilty: net/ipv4/route.c

$ nm net/ipv4/route.o | grep kmalloc
                 U __you_cannot_kmalloc_that_much

> 	    sh64: need kernel headers that would make glibc happy enough
> to build libc headers for that puppy;

binutils already compiled. Will drop a line. Or file a bug. :-\

