Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUHZLE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUHZLE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUHZK7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:59:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:19852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268686AbUHZK5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:57:10 -0400
Date: Thu, 26 Aug 2004 03:55:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Spam <spam@tnonline.net>
Cc: wichert@wiggy.net, jra@samba.org, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826035500.00b5df56.akpm@osdl.org>
In-Reply-To: <742303812.20040826125114@tnonline.net>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<112698263.20040826005146@tnonline.net>
	<Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	<1453698131.20040826011935@tnonline.net>
	<20040825163225.4441cfdd.akpm@osdl.org>
	<20040825233739.GP10907@legion.cup.hp.com>
	<20040825234629.GF2612@wiggy.net>
	<1939276887.20040826114028@tnonline.net>
	<20040826024956.08b66b46.akpm@osdl.org>
	<839984491.20040826122025@tnonline.net>
	<20040826032457.21377e94.akpm@osdl.org>
	<742303812.20040826125114@tnonline.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> wrote:
>
> 
> 
> > Spam <spam@tnonline.net> wrote:
> >>
> >> 
> >> 
> >> > Spam <spam@tnonline.net> wrote:
> >> >>
> >> >>    Yes,  for  example  documents,  image  files  etc. The multiple data
> >> >>    streams  can  contain thumbnails, info about who is editing the file
> >> >>    (useful for networked files) etc. Could be used for version handling
> >> >>    and much more.
> >> 
> >> > All of which can be handled in userspace library code.
> >> 
> >> > What compelling reason is there for doing this in the kernel?
> >> 
> >> 
> >>   Because  having user space tools and code will make it not work with
> >>   everything. Keeping stuff in the kernel should make the new features
> >>   transparent to the applications.
> >> 
> >>   Applications  that support the new features will benefit, all others
> >>   will continue to work without destroying data.
> 
> > Sorry, but that all sounds a bit fluffy.   Please provide some examples.
> 
>   We  already had the examples with cp and mv. Both should continue to
>   work and the files will still be copied. The same with Konqueror and
>   Nautilus.  Files  and  their  meta-files/streams/attributes  will be
>   retained as long as applications are using the OS API.
> 
>   However,  if  things  are  to  implemented  in  user-space, then old
>   applications  will not work correctly and there is risk that all the
>   extra information will be lost or corrupted.
> 
>   You  said  it  would be socially hard. I think it would be very much
>   close to impossible to get it right. Imagine that Gnome and Nautilus
>   would  implement  support  for  these. I doubt that cp, mv, KDE, mc,
>   app-xyz  would  implement  this anytime soon and in the meantime the
>   data is at risk.
> 

No.  All of the applications which you initially identified can be
implemented by putting the various bits of data into a single file and
getting applications to agree on the format of that file.

For example, some image file formats already support embedded metadata, do
they not?

