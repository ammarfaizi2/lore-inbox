Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbREOUQS>; Tue, 15 May 2001 16:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbREOUQI>; Tue, 15 May 2001 16:16:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8864 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261431AbREOUPw>;
	Tue, 15 May 2001 16:15:52 -0400
Date: Tue, 15 May 2001 16:15:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <3B018C83.CC3228AC@transmeta.com>
Message-ID: <Pine.GSO.4.21.0105151615230.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, H. Peter Anvin wrote:

> Alexander Viro wrote:
> > 
> > On 15 May 2001, H. Peter Anvin wrote:
> > 
> > > isofs wouldn't be too bad as long as struct mapping:struct inode is a
> > > many-to-one mapping.
> > 
> > Erm... What's wrong with inode->u.isofs_i.my_very_own_address_space ?
> > 
> 
> None whatsoever.  The one thing that matters is that noone starts making
> the assumption that mapping->host->i_mapping == mapping.

One actually shouldn't assume that mapping->host is an inode.

