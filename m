Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154483AbQDKJPk>; Tue, 11 Apr 2000 05:15:40 -0400
Received: by vger.rutgers.edu id <S154460AbQDKJPU>; Tue, 11 Apr 2000 05:15:20 -0400
Received: from dukat.scot.redhat.com ([195.89.149.246]:2304 "EHLO dukat.scot.redhat.com") by vger.rutgers.edu with ESMTP id <S153923AbQDKJPH>; Tue, 11 Apr 2000 05:15:07 -0400
Date: Tue, 11 Apr 2000 10:14:18 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: sct@redhat.com, alan@lxorguk.ukuu.org.uk, kanoj@google.engr.sgi.com, manfreds@colorfullife.com, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: zap_page_range(): TLB flush race
Message-ID: <20000411101418.E2740@redhat.com>
References: <200004082331.QAA78522@google.engr.sgi.com> <E12e4mo-0003Pn-00@the-village.bc.nu> <20000410232149.M17648@redhat.com> <200004102312.QAA05115@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200004102312.QAA05115@pizda.ninka.net>; from davem@redhat.com on Mon, Apr 10, 2000 at 04:12:18PM -0700
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Mon, Apr 10, 2000 at 04:12:18PM -0700, David S. Miller wrote:
>    On Sun, Apr 09, 2000 at 12:37:05AM +0100, Alan Cox wrote:
>    > 
>    > Basically establish_pte() has to be architecture specific, as some processors
>    > need different orders either to avoid races or to handle cpu specific
>    > limitations.
> 
>    What exactly do different architectures need which set_pte() doesn't 
>    already allow them to do magic in?  
> 
> Doing a properly synchronized PTE update and Cache/TLB flush when the
> mapping can exist on multiple processors is not most efficiently done
> if we take some generic setup.

OK, I'm sure there are optimisation issues, but I was worried about
correctness problems from what Alan said.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
