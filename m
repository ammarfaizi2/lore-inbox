Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283626AbRL1RF6>; Fri, 28 Dec 2001 12:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbRL1RFs>; Fri, 28 Dec 2001 12:05:48 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:22285 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283626AbRL1RFl>; Fri, 28 Dec 2001 12:05:41 -0500
Date: Fri, 28 Dec 2001 09:07:48 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Jeffrey W. Baker" <jwb@saturn5.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 absurd number of context switches
In-Reply-To: <E16K0OX-00015u-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112280907060.1466-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Alan Cox wrote:

> > Check out those figures for context switches!  30,000 switches per second
> > with only three runnable processes and practically no block I/O seems
> > quite high to me.  You can also see that the system is spending half its
> ..
> > Is this a scheduler worst-case, something to be expected, or something I
> > can work around?
>
> The scheduler is _good_ at the three process case. Run some straces it looks
> more like postgres is doing wacky yield based locks.

The scheduler that Linus merged in 2.5.2-pre3 will solve the problem.



- Davide


