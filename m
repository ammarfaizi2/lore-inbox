Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSJ1MgN>; Mon, 28 Oct 2002 07:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSJ1MgN>; Mon, 28 Oct 2002 07:36:13 -0500
Received: from mail.cyberus.ca ([216.191.240.111]:16833 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S262420AbSJ1MgM>;
	Mon, 28 Oct 2002 07:36:12 -0500
Date: Mon, 28 Oct 2002 07:35:01 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
cc: Tim Hockin <thockin@hockin.org>, David Woodhouse <dwmw2@infradead.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: rtnetlink interface state monitoring problems.
In-Reply-To: <5.1.0.14.2.20021023124123.09b83e00@mail1.qualcomm.com>
Message-ID: <Pine.GSO.4.30.0210280711490.9849-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Oct 2002, Maksim (Max) Krasnyanskiy wrote:

>
> >netlink is a messaging system; so what i am thinking is creating
> >a event notifier for other devices other than network devices.
> >Something other non-network devices could use (eg bluetooth).
>
> What kind of events are we taking about ?
>

Currently,  for net events, notifier_call_chain() calls from the same
routines which also send netlink announcements. I am thinking actually
having notifier_call_chain make the netlink advertisements.
There are not that many subsystems that use notifier block calls (seems
the network subsytem is their best customer ;->)
i think it is the best async notification scheme in the kernel. Too bad
someone had to invent hotplug the way it is right now.
As i said earlier, the advantage with netlink is that you could easily
add a distributed event notification scheme since it is already in packet
format.

cheers,
jamal

