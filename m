Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbRHBVw2>; Thu, 2 Aug 2001 17:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269162AbRHBVwT>; Thu, 2 Aug 2001 17:52:19 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:62188 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S267163AbRHBVwN> convert rfc822-to-8bit; Thu, 2 Aug 2001 17:52:13 -0400
Date: Thu, 2 Aug 2001 14:52:11 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <20010802234434.E7650@unthought.net>
Message-ID: <Pine.LNX.4.33.0108021448400.21298-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Jakob Østergaard wrote:

> You fill up mem and you fill up swap, and you complain the box is
> acting funny ??

The kernel should save whatever memory it needs to do its work.  It isn't
my problem, from userland, to worry that I take the last page in the
machine.  If the kernel needs pages to operate efficiently, it had better
reserve them and not just hand them out until it locks up.

> This is a clear case of "Doctor it hurts when I ..."  - Don't do it !
>
> I'm interested in hearing how you would accomplish graceful
> performance degradation in a situation where you have used up any
> possible resource on the machine.  Transparent process back-tracking ?
> What ?

Gosh, here's an idea: if there is no memory left and someone malloc()s
some more, have malloc() fail?  Kill the process that required the memory?
I can't believe the attitude I am hearing.  Userland processes should be
able to go around doing whaever the fuck they want and the box should stay
alive.  Currently, if a userland process runs amok, the kernel goes into
self-fucking mode for the rest of the week.

-jwb

