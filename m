Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRAJESn>; Tue, 9 Jan 2001 23:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131946AbRAJESe>; Tue, 9 Jan 2001 23:18:34 -0500
Received: from web121.mail.yahoo.com ([205.180.60.129]:8713 "HELO
	web121.yahoomail.com") by vger.kernel.org with SMTP
	id <S131809AbRAJESR>; Tue, 9 Jan 2001 23:18:17 -0500
Message-ID: <20010110041815.23159.qmail@web121.yahoomail.com>
Date: Tue, 9 Jan 2001 20:18:15 -0800 (PST)
From: Cacophonix <cacophonix@yahoo.com>
Subject: Re: storage over IP (was Re: [PLEASE-TESTME] Zerocopy networking patch,
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, hch@caldera.de,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tracked the IP storage group too closely, but was at the San Diego IETF
where there were some interesting debates about this issue. 

There is a write-up at http://ips.pdl.cs.cmu.edu/mail/msg02598.html

Now I'm not sure if I agree with some of the assumptions. And I share your concern 
about using multiple tcp streams.

Thoughts?

cheers,
karthik


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > <http://www.ietf.org/internet-drafts/draft-ietf-ips-fcovertcpip-01.txt>
> > show that both use TCP/IP.  TCP/IP has variable length headers (or am i on
> > crack?), which totally complicates the receive path.
> 
> TCP has variable length headers. It also prevents you re-ordering commands
> in the stream which would be beneficial. I've not checked if the draft uses
> multiple TCP streams but then you have scaling questions. 
> 
> Alan
> 


__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
