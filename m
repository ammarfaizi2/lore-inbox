Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273826AbRJDLo3>; Thu, 4 Oct 2001 07:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273801AbRJDLoT>; Thu, 4 Oct 2001 07:44:19 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:39097 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S273796AbRJDLoB>;
	Thu, 4 Oct 2001 07:44:01 -0400
Date: Thu, 4 Oct 2001 07:41:39 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <bcrl@redhat.com>,
        <netdev@oss.sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110040831020.1727-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110040728190.9341-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Ingo Molnar wrote:

> i'm asking the following thing. dev->quota, as i read the patch now, can
> cause extra calls to ->poll() even though the RX ring of that particular
> device is empty and the driver has indicated it's done processing RX
> packets. (i'm now assuming that the extra-polling-for-a-jiffy line in the
> current patch is removed - that one is a showstopper to begin with.) Is
> this claim of mine correct?

There should be no extra calls to ->poll() and if there are we should
fix them. Take a look at the state machine i posted earlier.
The one liner is removed.

cheers,
jamal

