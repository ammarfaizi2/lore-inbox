Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbRAEVyq>; Fri, 5 Jan 2001 16:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEVyg>; Fri, 5 Jan 2001 16:54:36 -0500
Received: from zeus.kernel.org ([209.10.41.242]:58830 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132109AbRAEVyR>;
	Fri, 5 Jan 2001 16:54:17 -0500
Date: Fri, 5 Jan 2001 21:52:23 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: Re: MM/VM todo list
Message-ID: <20010105215223.M1290@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0101051505430.1295-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0101051454230.2859-100000@freak.distro.conectiva> <20010105221326.A10112@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010105221326.A10112@caldera.de>; from hch@caldera.de on Fri, Jan 05, 2001 at 10:13:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 05, 2001 at 10:13:27PM +0100, Christoph Hellwig wrote:
> On Fri, Jan 05, 2001 at 02:56:40PM -0200, Marcelo Tosatti wrote:
> > > * VM: experiment with different active lists / aging pages
> > >   of different ages at different rates + other page replacement
> > >   improvements
> > > * VM: Quality of Service / fairness / ... improvements
> >   * VM: Use kiobuf IO in VM instead buffer_head IO. 
> 
> I'd vote for killing both bufer_head and kiobuf from VM.
> Lokk at my pageio patch - VM doesn't know about the use of kiobufs
> in the filesystem IO...

It has already been talked about, and is something I'd like for 2.5
--- it's easy enough to push the buffer-head list into the
per-address-space structures so that the upper VM has no knowledge of
the IO mechanism being used underneath.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
