Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272878AbTG3NHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272880AbTG3NHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:07:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272878AbTG3NHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:07:19 -0400
Date: Wed, 30 Jul 2003 09:07:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <20030730061454.GA19808@codepoet.org>
Message-ID: <Pine.LNX.4.53.0307300855540.193@chaos>
References: <20030730061454.GA19808@codepoet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Erik Andersen wrote:

>
> Here ya go...  This rips out the screen blanking code by the
> roots since the kind and gentle approach didn't seem to be what
> you were looking for.  :-)

Come on...

That's not necessary! I'm looking for either making it default
to "no blanking" so startup scripts need to enable this feature,
or an ioctl to turn it off.

The 'kindest and gentlist' approach was to simply set the timer
variable "blankinterval" (line 165 in console.c) to 0 instead of
10*60*HZ. This doesn't work. The screen still blanks in 10 minutes.

The next approach was to make an ioctl function. I was supplied with
1/2 what was necessary and, if I add the rest (a trivial call), it
will work, however that extra code may probably be rejected as
'bloat'.

What I'm working on now, when I can get the time, is trying to
find out how come initialization to zero doesn't work and making
it work. Once this is done, there should not be any technical
reasons why it can't be included in the standard kernel.

The current enabling of the blanker by default is clearly policy
and it has been well established that policy decisions should be
outside the kernel.

[SNIPPED (neat) patch...]



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

