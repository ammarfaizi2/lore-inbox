Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274305AbRJEW7Q>; Fri, 5 Oct 2001 18:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJEW7G>; Fri, 5 Oct 2001 18:59:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33035 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274298AbRJEW6q>; Fri, 5 Oct 2001 18:58:46 -0400
Subject: Re: Context switch times
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sat, 6 Oct 2001 00:04:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), george@mvista.com (george anzinger),
        bcrl@redhat.com (Benjamin LaHaise),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0110051553220.1523-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Oct 05, 2001 03:56:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pe0t-0007wz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This damps down task thrashing a bit, and for the cpu hogs it gets the
> > desired behaviour - which is that the all run their full quantum in the
> > background one after another instead of thrashing back and forth
> 
> What if we give to  prev  a priority boost P=F(T) where T is the time
> prev  is ran before the current schedule ?

That would be the wrong key. You can argue certainly that it is maybe
appropriate to use some function based on remaining scheduler ticks, but
that already occurs as the scheduler ticks is the upper bound for priority
band
