Return-Path: <linux-kernel-owner+w=401wt.eu-S1754515AbWLRUIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbWLRUIi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbWLRUIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:08:37 -0500
Received: from lucidpixels.com ([66.45.37.187]:44530 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515AbWLRUIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:08:36 -0500
Date: Mon, 18 Dec 2006 15:08:35 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS Filesystem Size Limit?
In-Reply-To: <1166472455.5742.48.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0612181508300.31233@p34.internal.lan>
References: <Pine.LNX.4.64.0612181419010.2396@p34.internal.lan>
 <1166472455.5742.48.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info!

On Mon, 18 Dec 2006, Trond Myklebust wrote:

> On Mon, 2006-12-18 at 14:21 -0500, Justin Piszcz wrote:
> > I have a question I could not quickly find on Google/mailing lists--
> > 
> > Say I have some sort of global filesystem or NFS which is 200TB.
> > 
> > Is there a limit either:
> > 
> > A) In the Linux kernel
> > or
> > B) In the NFS spec
> > 
> > That would limit the client as to what it could see via NFS or global 
> > filesystem?
> 
> No.
> 
> > Or could both 2.4 and 2.6 kernels 'see' the 200TB global filesystem over 
> > NFS or global filesystem?
> 
> 'df' may or may not report the filesystem size correctly (depends on
> whether you have VFS support for 64-bit filesystems enabled, and whether
> or not you are using NFSv3 or above), but you should be able to store
> 200TB worth or data on it irrespective of that.
> 
> The one thing that may be limited is the size of individual files. The
> NFSv2 protocol limits file sizes to 2GB, whereas NFSv3 and v4 should
> allow you to read and write full 64-bit sized files.
> Note though, that on most 32-bit hardware, the Linux VM design limits
> you to 44-bit file sizes (due to the 32-bit page table + 4k page size).
> 
> Cheers
>   Trond
> 
