Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbRATTp4>; Sat, 20 Jan 2001 14:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131214AbRATTpp>; Sat, 20 Jan 2001 14:45:45 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:31498 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130324AbRATTpn>; Sat, 20 Jan 2001 14:45:43 -0500
Date: Sat, 20 Jan 2001 15:55:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Hellwig <hch@caldera.de>
cc: Rajagopal Ananthanarayanan <ananth@sgi.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic IO write clustering
In-Reply-To: <20010120200514.A26170@caldera.de>
Message-ID: <Pine.LNX.4.21.0101201543520.6670-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Jan 2001, Christoph Hellwig wrote:

> On Sat, Jan 20, 2001 at 02:00:24PM -0200, Marcelo Tosatti wrote:
> > > True.  But you have to go through ext2_get_branch (under the big kernel
> > > lock) - if we can do only one logical->physical block translations,
> > > why doing it multiple times?
> > 
> > You dont. If the metadata is cached and uptodate there is no need to call
> > get_block().
> 
> Ups.  You are right for the stock tree - I was only looking at my kio tree,
> where it can't be cached due to the lack of buffer-cache usage...

Must be fixed.  

We need a higher level abstraction which can hold this (and other)
information.

Take a look at SGI's pagebuf page_buf_t. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
