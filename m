Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263264AbREaWoI>; Thu, 31 May 2001 18:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbREaWn5>; Thu, 31 May 2001 18:43:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:56590 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263209AbREaWnx>; Thu, 31 May 2001 18:43:53 -0400
Date: Thu, 31 May 2001 15:43:34 -0700 (PDT)
From: "H. Peter Anvin" <hpa@transmeta.com>
To: Peter Waltenberg <peterw@dascom.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to know HZ from userspace?
In-Reply-To: <XFMail.20010601083302.peterw@dascom.com.au>
Message-ID: <Pine.LNX.4.31.0105311541300.30345-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Peter Waltenberg wrote:

> Yes, I know we have a chance of being rescheduled simply because "something
> else" has also yielded. However thats fairly hit and miss.
>
> I don't disagree with your statement that thats how the interface should be
> designed, but the most of the apps that could use it still have an unreliable
> interface. i.e. you ask to be woken in 2.54mS, on X86 it'll likely be ~10mS,
> on Alpha ~3mS. Now and then you'll get woken somewhere near the time you
> requested.
>

First of all, the unit of time is the second (s), not the siemens (S).

Second, I think we're talking about different things.  I'm talking about
interfaces (/proc, ioctl, etc.) in which durations are specified in
jiffies.  This is unacceptable.

What you seem to be talking about is user-space insight into the
scheduling algorithm, which is another matter.

	-hpa


