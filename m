Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbTD3TAC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbTD3TAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:00:01 -0400
Received: from pat.uio.no ([129.240.130.16]:54240 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262326AbTD3S76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:59:58 -0400
Date: Wed, 30 Apr 2003 21:12:17 +0200 (MEST)
From: =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
Subject: Re: sendfile
In-Reply-To: <20030430165103.GA3060@outpost.ds9a.nl>
Message-ID: <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no>
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no>
 <20030430165103.GA3060@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, bert hubert wrote:

> > Does sendfile support UDP connections (SOCK_DGRAM)?
>
> Try it. I bet it doesn't do so, and certainly not usably. Blasting UDP
> frames is seldomly useful without checks, like NFS performs.

It could be useful for applications like streaming video where other
protocols on top provide additional functionality or in a multicast
session where TCP migth not be appropriate.

> > Does sendfile remove ALL in-memory data copy operations?
>
> Depends. With some network adaptors it might. Definition of 'zero-copy' is
> somewhat misty. Some variants of zero-copy would actually be called
> 'one-copy' or 'minus-one-copy' in other contexts.

But should not the 2.4.X kernels have support for chained sk_buffs (like
the BSD mbufs) meaning that support for scatter-gatter I/O from the NIC
should be unneccessary to support zero-copy (i.e., NO in-memory data
copy operations)?

> Regards,
>
> bert

Cheers,
-ph
