Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269356AbRHTU5a>; Mon, 20 Aug 2001 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269354AbRHTU5V>; Mon, 20 Aug 2001 16:57:21 -0400
Received: from [213.4.18.231] ([213.4.18.231]:18194 "EHLO fulanito.nisupu.com")
	by vger.kernel.org with ESMTP id <S269350AbRHTU5P>;
	Mon, 20 Aug 2001 16:57:15 -0400
Message-ID: <008701c129ba$8db6ae20$0414a8c0@10>
From: =?iso-8859-1?Q?Carlos_Fern=E1ndez_Sanz?= 
	<cfs-lk@fulanito.nisupu.com>
To: "Ignacio Vazquez-Abrams" <ignacio@openservices.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108201644440.11734-100000@terbidium.openservices.net>
Subject: Re: Fw: select(), EOF...
Date: Mon, 20 Aug 2001 22:56:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How come the process is never runnable unless there's new data in the file?
If it was opening and closing the file continously it would be using lots of
CPU, while it's 0 if there's no data coming.

----- Original Message -----
From: "Ignacio Vazquez-Abrams" <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, August 20, 2001 10:45 PM
Subject: Re: Fw: select(), EOF...


> On Mon, 20 Aug 2001, Carlos Fernández Sanz wrote:
>
> > (sorry if this is a dupe, I haven't seen it come from the list, so I'm
> > resending as plain ASCII in case majordomo kills messages with strange
> > stuff)
> >
> > Hi,
> >
> > I need to do something similar to tail -f.
> > I was hoping that select() or poll() would block my process after
reaching
> > EOF but (as the man says) EOF doesn't cause read() to block so select()
and
> > poll() both say I can read. The result is (obviously) that my program
waits
> > actively and uses all the CPU.
> > What's the right way of doing this? I assume the kernel provides
facilities
> > to find out if there is new data to read (other than EOF).
> >
> > Thanks.
>
> tail -f just alternates between open() and close(), keeping in memory the
> current byte offest into the file.
>
> --
> Ignacio Vazquez-Abrams  <ignacio@openservices.net>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

