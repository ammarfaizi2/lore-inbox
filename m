Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRAEV1X>; Fri, 5 Jan 2001 16:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbRAEV1N>; Fri, 5 Jan 2001 16:27:13 -0500
Received: from ns.caldera.de ([212.34.180.1]:43527 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129881AbRAEV07>;
	Fri, 5 Jan 2001 16:26:59 -0500
Date: Fri, 5 Jan 2001 22:26:24 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
Message-ID: <20010105222624.A11770@caldera.de>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010105221326.A10112@caldera.de> <Pine.LNX.4.21.0101051918550.1295-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0101051918550.1295-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Jan 05, 2001 at 07:20:24PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 07:20:24PM -0200, Rik van Riel wrote:
> > >   * VM: Use kiobuf IO in VM instead buffer_head IO. 
> > 
> > I'd vote for killing both bufer_head and kiobuf from VM.
> > Lokk at my pageio patch - VM doesn't know about the use of kiobufs
> > in the filesystem IO...
> 
> Could be interesting ... but is it generalised enough to
> also work with eg. network IO ?

No other then filesystem IO (page/buffercache) is actively tied to the VM,
so there should be no problems.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
