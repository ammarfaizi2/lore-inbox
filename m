Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbRFYHWh>; Mon, 25 Jun 2001 03:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265884AbRFYHW2>; Mon, 25 Jun 2001 03:22:28 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:55277 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265726AbRFYHWN>; Mon, 25 Jun 2001 03:22:13 -0400
From: David Lang <david.lang@digitalinsight.com>
To: ebiederm@xmission.com
Cc: John Nilsson <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
Date: Sun, 24 Jun 2001 23:09:46 -0700 (PDT)
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <m17ky1b4or.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0106242308100.7535-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you don't preserve things running in userspace what advantage do you
have over rebooting?

if you do preserve userspace stuff then you need to also preserve the
kernel state related to each user process (including network connections,
etc), and here you are back into the problem that the kernel structures
may change on you.

David Lang



 On 24 Jun 2001 ebiederm@xmission.com wrote:

> Date: 24 Jun 2001 21:48:20 -0600
> From: ebiederm@xmission.com
> To: David Lang <david.lang@digitalinsight.com>
> Cc: John Nilsson <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
> Subject: Re: Some experience of linux on a Laptop
>
> David Lang <david.lang@digitalinsight.com> writes:
>
> > On Sun, 24 Jun 2001, John Nilsson wrote:
> > > 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> > > in my laptop so I often do drastic things when I install a new distribution.
> >
> > this is suggested every few months, the normal answer is that there is a
> > lot of stuff that the new kernel needs to know from the old one to make
> > the handoff sucessful, with potentially drastic changes of the kernel
> > internal structures it's a very difficult thing to do.
>
> What do you want this for?  If you don't need to preserve user space
> I have code that already does this.  If you need to preserver the user
> space it is a trickier problem.  But I have heard rumors of a suspend
> to swap patch...
>
> Eric
>
