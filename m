Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266300AbUAGSOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUAGSOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:14:36 -0500
Received: from pop.gmx.de ([213.165.64.20]:30648 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266300AbUAGSO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:14:26 -0500
X-Authenticated: #20450766
Date: Wed, 7 Jan 2004 19:13:46 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <20040107174939.GK1882@matchmail.com>
Message-ID: <Pine.LNX.4.44.0401071908320.1840-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Mike Fedyk wrote:

> On Tue, Jan 06, 2004 at 01:46:30AM +0100, Guennadi Liakhovetski wrote:
> > It is not just a problem of 2.6 with those specific network configurations
> > - ftp / http / tftp transfers work fine. E.g. wget of the same file on the
> > PXA with 2.6.0 from the PC1 with 2.4.21 over http takes about 2s. So, it
> > is 2.6 + NFS.
> >
> > Is it fixed somewhere (2.6.1-rcx?), or what should I try / what further
> > information is required?
>
> You will probably need to look at some tcpdump output to debug the problem...

Yep, just have done that - well, they differ... First obvious thing that I
noticed is that 2.6 is trying to read bigger blocks (32K instead of 8K),
but then - so far I cannot interpret what happens after the start of the
actual file-read. 2.6 starts getting big delays immediately, even in
cases, where eventually the file is transferred (2 PCs with 2.6). If
someone can get some information from the logs, I'll happily send them.
The bz2 tarball is 50k big, so, not too bad for the list either, but it is
not a common practice to send compressed attachments to the list, right?
It's 5M uncompressed.

Thanks
Guennadi
---
Guennadi Liakhovetski


