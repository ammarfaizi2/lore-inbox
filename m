Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWBBREI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWBBREI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWBBREI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:04:08 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:59625 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932161AbWBBREH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:04:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G8+cPDHmGIMf5Acapf06nVbohwzuy2uotjmIW09PLeRxmsxIeTfc1b+uojAz1SuL7jzzEPaW93wYHVdMDm5GuLV1nAIsYQcMGu87OCCul5Y0GVx7ZYP1AIye5XPDLe+kmNljd6R9renhml18Xxxw0r6fia6YtB1noEgFcXFsl+g=
Message-ID: <9a8748490602020904m10d5a1e6h4e343ed7fbc71c87@mail.gmail.com>
Date: Thu, 2 Feb 2006 18:04:06 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Fabio d'Alessi" <cars@bio.unipd.it>
Subject: Re: PROBLEM: kernel BUG at lib/kernel_lock.c:199!
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43E2217B.9050404@bio.unipd.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43E2217B.9050404@bio.unipd.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Fabio d'Alessi <cars@bio.unipd.it> wrote:
>
> Dear sirs,
> I have a problem with a dual athlon xp running fedora/4
> with the 2.6.14-1 kernel. Hard locks. Please if anyone
[...]
> [7.1] standard fedora 4 install - nothing new added, just the
> drivers for the nv graphic board.
>
Adding the binary only nvidia module is not a little thing.
That driver is a closed source binary blob that noone here has a
chance to debug.

You can switch to the 'nv' driver and see if you still have the
problem. The nv driver won't give you accelerated 3D, but for 2D it
should work just fine.

[...]
> nvidia 4095984 12 - Live 0xf8f31000
[...]
Please try to reproduce without the nvidia driver ever being loaded -
just unloading it is *not* good enough, it needs to have never been
loaded at all.
As long as that (or any other binary-only module for that matter) has
been loaded into the kernel for just a second it's impossible to say
if that module or some other part of the kernel is the cause of the
problem.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
