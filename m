Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVKQTLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVKQTLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVKQTLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:11:22 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:32150
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S964774AbVKQTLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:11:21 -0500
Message-ID: <20051117191119.15126.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: Nish Aravamudan <nish.aravamudan@gmail.com>
cc: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org, dag@newtech.fi
Subject: Re: nanosleep with small value 
In-Reply-To: Message from Nish Aravamudan <nish.aravamudan@gmail.com> 
   of "Thu, 17 Nov 2005 10:51:03 PST." <29495f1d0511171051q6088099drfe094817a01668e4@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Nov 2005 21:11:19 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 11/17/05, Dag Nygren <dag@newtech.fi> wrote:

> > The man page for nanosleep saya that times under 2 us are implemented
> > by a busywait and  this is why I expected it to work.
> 
> Update your manpages. You're depending on 2.4 behavior in a 2.6 kernel.

You are right. The system is one I have upgraded piece by piece and the 
manpages
weren't upgraded.

But what is the point of having a nanosleep() in that case when you could do
just fine with usleep() ?

> > OK, in that case the manpage should be changed. And an alternative
> > has to be worked out by me ;-).
> 
> My man-pages are quite clear on what nanosleep() does. Nothing needs
> to be changed there.
> 
> Alternative wise, I'm not sure, but you might want to look into the
> HRT stuff that's going on in Ingo's -RT tree. I don't know if / what
> changes have been made to sys_nanosleep(), but low-latency is most
> likely to occur there.

I will look into that.
Quite annoying that software that worked just fine in 2.4 doesn't
work in 2.6.

What does POSIX say about nanosleep()?

Dag

