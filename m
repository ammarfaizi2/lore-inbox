Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129491AbRBXSAI>; Sat, 24 Feb 2001 13:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129502AbRBXR75>; Sat, 24 Feb 2001 12:59:57 -0500
Received: from [216.151.155.116] ([216.151.155.116]:5382 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129513AbRBXR7r>; Sat, 24 Feb 2001 12:59:47 -0500
To: Mark Swanson <swansma@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 242-ac3 loop bug
In-Reply-To: <20010224173234.14673.qmail@web1301.mail.yahoo.com>
From: Doug McNaught <doug@wireboard.com>
Date: 24 Feb 2001 12:59:44 -0500
In-Reply-To: Mark Swanson's message of "Sat, 24 Feb 2001 09:32:34 -0800 (PST)"
Message-ID: <m34rxk0xnz.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Swanson <swansma@yahoo.com> writes:

> > ps -aux | grep loop
> 1674 tty1     DW<   0:00 [loop0]
> 
> The system is doing nothing to the loop filesystem.
> Strange that the process isn't logging any cpu usage time. It's
> definately responsible for the 1.00 load.

It's just an artifact of the fact that processes in state D
(uninterruptible sleep) are included in the load average calculation.
Since the loop thread apparently sits in state D waiting for events
on its device, you get a load average of 1 for each mounted loop
device. 

I know nothing about the implementation of the loop thread so won't
presume to say whether/how it can be "fixed". 

-Doug
