Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbQKJXSw>; Fri, 10 Nov 2000 18:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131750AbQKJXSl>; Fri, 10 Nov 2000 18:18:41 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60420 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130270AbQKJXS3>; Fri, 10 Nov 2000 18:18:29 -0500
Message-ID: <3A0C8117.20853855@timpanogas.org>
Date: Fri, 10 Nov 2000 16:13:27 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: sendmail-bugs@sendmail.org
CC: Igmar Palsenberg <maillist@chello.nl>, root@chaos.analogic.com,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <3A0C5EDC.3F30BE9C@timpanogas.org> <Pine.LNX.4.21.0011110113590.6465-100000@server.serve.me.nl> <20001110151232.A16552@sendmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Claus Assmann wrote:
> 
> On Sat, Nov 11, 2000, Igmar Palsenberg wrote:
> >
> > > > It ran out of memory. The file got sent fine after I got rid of
> > > > all the memory-consumers. Looks like a sendmail bug where they
> > > > expect to load a whole file into memory all at once before sending
> > > > it. I always thought you could read from a file, then write to
> 
> As I wrote before: this is just wrong. sendmail doesn't
> load the file into memory.
> 
> > > > a socket. Maybe I'm old fashioned.
> >
> > Sending a 50 MB file is OK here. So it's not a TCP/IP bug.
> 
> Ok, hopefully this reaches everyone who has been "involved"
> by Jeff into this "problem".
> 
> It turned out that this was just a misconfiguration on his box
> (the load average exceeded the limit of his sendmail).
> 
> Can we please close this case now? Thanks.

There was also an issue relative to how sendmail is interpreting load
average on a linux box.  hpa@transmeta.com pointed out that perhaps you
are not factoring sleeping processes, which Linux does -- a deviation
from BSD's interpretation of load average.  With a handle like
"Assmann", deviation is proably something you already understand quite
well ...

8)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
