Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRATMZz>; Sat, 20 Jan 2001 07:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRATMZo>; Sat, 20 Jan 2001 07:25:44 -0500
Received: from plzena-225.dialup.vol.cz ([212.20.120.226]:31492 "HELO
	madness.madness.mad") by vger.kernel.org with SMTP
	id <S129383AbRATMZb>; Sat, 20 Jan 2001 07:25:31 -0500
Date: Sat, 20 Jan 2001 13:26:08 +0100 (CET)
From: Martin MaD Douda <martin@douda.net>
To: Michael Lindner <mikel@att.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data
  available
In-Reply-To: <3A68F855.6F16F152@att.net>
Message-ID: <Pine.LNX.4.21.0101201322110.839-100000@madness.madness.mad>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2001, Michael Lindner wrote:

> data is generated as a result of data received via a select(),
> the next delivery occurs a clock tick later, with the machine
> mostly idle.
  ^^^^^^^^^^^

The machine is in fact not idle - there is a task running - idle task.
Could the problem be that scheduler does not preempt this task to run
something more useful?

Symptoms seems to show this. 

			Martin




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
