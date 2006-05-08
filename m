Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWEHLS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWEHLS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 07:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWEHLS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 07:18:29 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:24054 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751200AbWEHLS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 07:18:28 -0400
Date: Mon, 8 May 2006 13:18:27 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Dave Pitts <dpitts@cozx.com>, linux-kernel@vger.kernel.org
Subject: Re: How can I boost block I/O performance
Message-ID: <20060508111827.GB1875@harddisk-recovery.com>
References: <445CE6ED.30703@cozx.com> <9a8748490605061655oaa7e114ua5dbf47206d92fd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490605061655oaa7e114ua5dbf47206d92fd6@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 01:55:12AM +0200, Jesper Juhl wrote:
> On 5/6/06, Dave Pitts <dpitts@cozx.com> wrote:
> >Hello all:
> >
> >I've been trying some hacks to boost disk I/O performance
> [snip]
> >
> >This test is running several NFS clients to a RAID disk storage array. I
> [snip]
> 
> For improving performance of NFS servers I've often had good success
> with increasing the 'rsize' and 'wsize' options.
> The default values are 4096, I personally set them to 16384 which
> usually helps NFS performance quite a bit. At least that's my
> experience.
> Simply add  rsize=16384,wsize=16384  to the nfs mount options in
> /etc/fstab and see if that improves performance for you (values like
> 8192 and 32768 may also be worth testing, but personally I've found -
> at least with my setups - that 16384 seems to be the magic value).
> ('man 8 mount' and 'man 5 exports' also have more interresting options
> you may want to experiment with, but just rsize & wsize on their own
> should be a boost)

Another way is to increase the number of nfsd threads on the server.
See rpc.nfsd(8). I usually increase it from the default 8 to 32 on busy
machines.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
