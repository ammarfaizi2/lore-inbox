Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311083AbSCHU1N>; Fri, 8 Mar 2002 15:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311080AbSCHU07>; Fri, 8 Mar 2002 15:26:59 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:48140 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S311079AbSCHU0q>; Fri, 8 Mar 2002 15:26:46 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 8 Mar 2002 12:30:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        george anzinger <george@mvista.com>
Subject: Re: gettimeofday() system call timing curiosity
In-Reply-To: <20020308201633.C18247@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0203081227210.1701-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Jamie Lokier wrote:

> It's the _median_ that varies from 453 to 470, not the _mean_, so the
> accumulation to 17000 cycles doesn't apply.

I was doing something similar and i got huge numbers out of a small mean.
It was the recalc loop that hit inside the scheduler or in this case it
could be a schedule() entry due a need_resched set by the timer. From the
number of cycles it seems possible.



- Davide


