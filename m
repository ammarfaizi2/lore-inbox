Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130875AbRAEVfe>; Fri, 5 Jan 2001 16:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbRAEVfZ>; Fri, 5 Jan 2001 16:35:25 -0500
Received: from ns.caldera.de ([212.34.180.1]:49159 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130875AbRAEVfS>;
	Fri, 5 Jan 2001 16:35:18 -0500
Date: Fri, 5 Jan 2001 22:34:59 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
Message-ID: <20010105223459.A12653@caldera.de>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010105222624.A11770@caldera.de> <Pine.LNX.4.21.0101051927040.1295-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0101051927040.1295-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Jan 05, 2001 at 07:27:38PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 07:27:38PM -0200, Rik van Riel wrote:
> > No other then filesystem IO (page/buffercache) is actively tied
> > to the VM, so there should be no problems.
> 
> Not right now, no. But if you know what is possible
> (and planned) with the kiobuf layer, you should think
> twice about this idea...

I don't think so.  The only place were IO actively interferes with
the VM is of the 'write this out when memory gets low' type thing,
and you don't really want this outside filesystems/blockdevices.

There are some VM tricks that are usefull for IO (COW, map_user_kiobuf),
but these operate always on pages (maybe containered by kiobufs, but that
should be of minor interest for the VM).

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
