Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289252AbSANO4q>; Mon, 14 Jan 2002 09:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289255AbSANO4h>; Mon, 14 Jan 2002 09:56:37 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:4359 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289252AbSANO4X>; Mon, 14 Jan 2002 09:56:23 -0500
Date: Mon, 14 Jan 2002 15:56:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: <yodaiken@fsmlabs.com>
cc: Momchil Velikov <velco@fadata.bg>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020114064548.D22065@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0201141541140.29505-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Jan 2002 yodaiken@fsmlabs.com wrote:

> is going to be an enormously important issue.  However, once you add SCHED_FIFO in the
> current scheme, this becomes more complex. And with preempt, you cannot even offer the
> assurance that once a process gets the cpu it will make _any_ advance at all.

I'm not sure if I understand you correctly, but how is this related to
preempt? A SCHED_FIFO tasks only delays SCHED_OTHER tasks, but it doesn't
consume their time slice, so the remaining tasks still get their
(previously assigned) time at the cpu, until all tasks have consumed
their share.

bye, Roman


