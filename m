Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289148AbSAGMuT>; Mon, 7 Jan 2002 07:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289168AbSAGMuJ>; Mon, 7 Jan 2002 07:50:09 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:53517 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289148AbSAGMuE>;
	Mon, 7 Jan 2002 07:50:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>,
        Peter W?chtler <pwaechtler@loewe-komp.de>
Subject: Re: [PATCH] updated version of radix-tree pagecache
Date: Mon, 7 Jan 2002 13:53:12 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Christoph Hellwig <hch@caldera.de>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>, velco@fadata.bg
In-Reply-To: <20020105171234.A25383@caldera.de> <3C3972D4.56F4A1E2@loewe-komp.de> <20020107030344.H10391@holomorphy.com>
In-Reply-To: <20020107030344.H10391@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NZHB-0001Q7-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 12:03 pm, William Lee Irwin III wrote:
> On Mon, Jan 07, 2002 at 11:05:08AM +0100, Peter W?chtler wrote:
> > Can you sum up the advantages of this implementation?
> > I think it scales better on "big systems" where otherwise you end up
> > with many pages on the same hash?
> > 
> > Is it beneficial for small systems? (I think not)
> 
> I speculate this would be good for small systems as well as it reduces
> the size of struct page by 2*sizeof(unsigned long) bytes, allowing more
> incremental allocation of pagecache metadata. I haven't tried it on my
> smaller systems yet (due to lack of disk space and needing to build the
> cross-toolchains), though I'm now curious as to its exact behavior there.

Benchmark it on UML.  In my experience, performance on UML is quite predictive of 
performance on native systems.

--
Daniel
