Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261444AbREOUW6>; Tue, 15 May 2001 16:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbREOUWs>; Tue, 15 May 2001 16:22:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33704 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261444AbREOUWd>;
	Tue, 15 May 2001 16:22:33 -0400
Date: Tue, 15 May 2001 16:22:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <3B018EF3.F9DF7207@transmeta.com>
Message-ID: <Pine.GSO.4.21.0105151621350.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, H. Peter Anvin wrote:

> Alexander Viro wrote:
> > >
> > > None whatsoever.  The one thing that matters is that noone starts making
> > > the assumption that mapping->host->i_mapping == mapping.
> > 
> > One actually shouldn't assume that mapping->host is an inode.
> > 
> 
> What else could it be, since it's a "struct inode *"?  NULL?

struct block_device *, for one thing. We'll have to do that as soon
as we do block devices in pagecache.

