Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135917AbRDZVBp>; Thu, 26 Apr 2001 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135933AbRDZVAx>; Thu, 26 Apr 2001 17:00:53 -0400
Received: from zeus.kernel.org ([209.10.41.242]:128 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135927AbRDZU7y>;
	Thu, 26 Apr 2001 16:59:54 -0400
X-Originating-IP: [12.19.166.64]
From: "Dan Mann" <daniel_b_mann@hotmail.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0104261529480.17635-100000@duckman.distro.conectiva>
Subject: Re: #define HZ 1024 -- negative effects?
Date: Thu, 26 Apr 2001 16:24:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Message-ID: <OE54ug1uBnF36bxQ3T100003b0d@hotmail.com>
X-OriginalArrivalTime: 26 Apr 2001 20:24:09.0038 (UTC) FILETIME=[D928C6E0:01C0CE8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, the kernel really doesn't have much of an effect on the interactivity of
the gui?  I really don't think there is a problem right now at the
console..but I am curious to help it at the gui level.  Does it have
anything to do with the way the mouse is handled? I've applied the mvista
preemptive + low latency patch, and my subjective experience is that it
"feels" the same.  I'd just like to help and I'll patch the hell out of my
kernel if you need someone to test it.  I don't really care if my hardrive
catches on fire as long as it doesn't burn my house down :-)

Dan

----- Original Message -----
From: "Rik van Riel" <riel@conectiva.com.br>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, April 26, 2001 2:31 PM
Subject: Re: #define HZ 1024 -- negative effects?


> On Thu, 26 Apr 2001, Adam J. Richter wrote:
>
> > I have not tried it, but I would think that setting HZ to 1024
> > should make a big improvement in responsiveness.
> >
> > Currently, the time slice allocated to a standard Linux
> > process is 5*HZ, or 50ms when HZ is 100.  That means that you
> > will notice keystrokes being echoed slowly in X when you have
> > just one or two running processes,
>
> Rubbish.  Whenever a higher-priority thread than the current
> thread becomes runnable the current thread will get preempted,
> regardless of whether its timeslices is over or not.
>
> And please, DO try things before proposing a radical change
> to the kernel ;)
>
> regards,
>
> Rik
> --
> Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml
>
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
>
> http://www.surriel.com/
> http://www.conectiva.com/ http://distro.conectiva.com/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
