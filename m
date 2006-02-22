Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWBVJ51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWBVJ51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 04:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWBVJ51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 04:57:27 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:57326 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932572AbWBVJ50 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 04:57:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GlJrRNn6a0RRMXAWJhB7PEsVLSFVDpHliWBb2HiQQLvgMRirwiS6dsmi5VfrRxabyxPxMJFeAcAK9l/Ohx4krtoGQDy5/EI2qB5aFwJap/jKxWjJbXwndATlWreB/SJvtaZ4kDn3VOa0DA2o2xAD7dkhZkWnGx8NSQLh3q+YN5M=
Message-ID: <69304d110602220157i71a1455cped625a19205cc4a7@mail.gmail.com>
Date: Wed, 22 Feb 2006 10:57:24 +0100
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Oleg Drokin" <green@linuxhacker.ru>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
In-Reply-To: <20060221142159.GI5733@linuxhacker.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060220221948.GC5733@linuxhacker.ru>
	 <20060220215122.7aa8bbe5.akpm@osdl.org>
	 <1140530396.7864.63.camel@lade.trondhjem.org>
	 <69304d110602210615m491829ccx9ba84edc8dafe1f7@mail.gmail.com>
	 <20060221142159.GI5733@linuxhacker.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Oleg Drokin <green@linuxhacker.ru> wrote:
> Hello!
>
> On Tue, Feb 21, 2006 at 03:15:53PM +0100, Antonio Vargas wrote:
> > > > We would need to understand whether this is needed by other distributed
> > > > filesystems and if so, whether the proposed implementation is suitable and
> > > > sufficient.
> > > Hmm.... We might possibly want to use that for NFSv4 at some point in
> > > order to deny write access to the file to other clients while it is in
> > > use.
> > When done with regards to failing a write if anyone has mapped the
> > file for executing it, or failing the execute if it's open/mmaped for
> > write, I can't really see the difference between local, remote and
> > clustered filesystems...
>
> Currently this is only possible locally, when both execution and opening
> for writing is performed on the same node. Then VFS enforces ETXTBSY.
> But if you do exec on one node and open for writing on another,
> VFSes on those nodes have no idea on what happens on all other nodes.
>

Thanks for the enlightement Oleg, I had assumed the owner of the file
to write over the executable while it's being executed... sort of
self-modifying code, but s/self/external/ ;)

Greetz, Antonio Vargas aka winden of network
