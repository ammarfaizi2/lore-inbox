Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277268AbRJDXrM>; Thu, 4 Oct 2001 19:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277266AbRJDXrD>; Thu, 4 Oct 2001 19:47:03 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:62738 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S277271AbRJDXqw>; Thu, 4 Oct 2001 19:46:52 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>, mingo@elte.hu,
        jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
In-Reply-To: <20011004192645.A20389@redhat.com>
In-Reply-To: <20011004174945.B18528@redhat.com>
	<309455016.1002241234@[195.224.237.69]>  <20011004192645.A20389@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.03.20.06 (Preview Release)
Date: 04 Oct 2001 19:47:10 -0400
Message-Id: <1002239236.872.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-04 at 19:26, Benjamin LaHaise wrote:
> Frankly I'm sick of this entire discussion where people claim that no 
> form of interrupt throttling is ever needed.  It's an emergency measure 
> that is needed under some circumstances as very few drivers properly 
> protect against this kind of DoS.  Drivers that do things correctly will 
> never trigger the hammer.  Plus it's configurable.  If you'd bothered to 
> read and understand the rest of this thread you wouldn't have posted.

Agreed.  I am actually amazed that the opposite of what is happening
does not happen -- that more people aren't clamoring for this solution.

Six months ago I was testing some TCP application and by accident placed
a sendto() in an infinite loop.  The destination of the packets (on my
LAN) locked up completely!  And this was a powerful Pentium III with a
3c905 NIC.  Not acceptable.

	Robert Love

