Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154119-8316>; Fri, 11 Sep 1998 04:33:26 -0400
Received: from portofix.ida.liu.se ([130.236.177.25]:48151 "EHLO portofix.ida.liu.se" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154164-8316>; Fri, 11 Sep 1998 04:27:34 -0400
Message-Id: <199809111113.NAA06473@portofix.ida.liu.se>
To: "David S. Miller" <davem@dm.cobaltmicro.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: [TIMINGS] Re: 2.1.xxx makes Electric Fence 22x slower 
In-Reply-To: Your message of "Thu, 10 Sep 1998 18:18:27 PDT." <199809110118.SAA27332@dm.cobaltmicro.com> 
Date: Fri, 11 Sep 1998 13:13:24 +0200
From: Patrik Hagglund <patha@ida.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu

David S. Miller wrote:

>   Date: Thu, 10 Sep 1998 22:22:32 +0100
>   From: "Stephen C. Tweedie" <sct@redhat.com>
>
>   David, not only is the fuzzy hash O(n) (with low constant) for lookup,
>   it is also O(n) for insert, requiring insertion onto two separate
>   ordered lists...
>
> No it isn't, for the insert case you have to find the neighbours
> anyways so the cost of a lookup is what you eat and this is an
> unavoidable overhead no matter what algorithm you use.

I don't think your arguments make sense. I think you can avoid finding
the neighbors (explicitly) in insert by coding it differently.
Unfortunately, I'm to busy to produce any code right now.

One the other hand, the argument that the algorithm is O(n) (instead
of O(log n)) doesn't say that much unless we are talking of really big
n:s (because of the low constant), which as I understood was not the
case here.

By the way, I just found out that the very first Forth implementation
also used a "fuzzy hashing" data structure to implement its
dictionary. See http://www.dnai.com/~jfox/f70c5.html.

Regards,
Patrik Hägglund

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
