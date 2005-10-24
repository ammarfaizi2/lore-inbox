Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVJXMCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVJXMCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 08:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVJXMCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 08:02:46 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:14100 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750916AbVJXMCp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 08:02:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4knLG9AaXQuKAo3dXhapjtbM+TK0VyNm+S7Vm9E/uAU5gQ9upbbQ/KyrsQmwXoWFEWuBNL4nB08O8hCgaXZLJWA8+ih03LpEWHVCv5T5c5awdQSRL0wT2Vk+yeRMhdKF9MPBQKZVTruLTHYdKFSaaaYmCRKOEUQt8ga4HjutgE=
Message-ID: <35fb2e590510240502p581e9ca1y8a8e27932935bcbf@mail.gmail.com>
Date: Mon, 24 Oct 2005 13:02:44 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: /proc/kcore size incorrect ?
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20051024015710.29a02e63@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051023235806.1a4df9ab@werewolf.able.es>
	 <35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com>
	 <20051024015710.29a02e63@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/05, J.A. Magallon <jamagallon@able.es> wrote:
> On Mon, 24 Oct 2005 00:13:44 +0100, Jon Masters <jonmasters@gmail.com> wrote:
>
> > On 10/23/05, J.A. Magallon <jamagallon@able.es> wrote:
> >
> > > BTW, any simple method to get the real mem of the box ?
> >
> > This is a typical example of using a hammer to crack a nut aka
> > modifying the kernel before giving up on userspace.

> Who talks about modifying anything ?

Your message implied that /proc/kcore needed "fixing" for your
particular application. Perhaps I missunderstood though.

> >     * man -k memory
> >
> > Leading to:
> >
> > * free(1):
> >     ``free  displays the total amount of free and used physical and swap''
> >
> > * Or /proc/meminfo (both the same thing) - which you can trivially
> > parse using sed:
> >
> > cat /proc/meminfo | sed -n -e "s/^MemTotal:[ ]*\([0-9]*\) kB\$/\1/p"

> Do your homework.

I did, thanks!

> free gives the free amount of memory _available for the user_, ie, the
> full memory of the box minus the kernel reserved part.

If you can't use the memory, what's the point in reporting it? If
you're really bothered, parse the dmesg output.

> It looks really silly to have a motd say "wellcome to this box, it has
> 2 xeons and 1022 Mb of RAM".

Yes it does. Showing off specs like that (and in your signature) went
out of fashion a while ago :-)

Jon.
