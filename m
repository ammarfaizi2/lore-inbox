Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTF0MAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 08:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTF0MAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 08:00:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:17571 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264219AbTF0MAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 08:00:41 -0400
Message-Id: <5.2.0.9.2.20030627134356.02019da0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 27 Jun 2003 14:18:56 +0200
To: Helge Hafting <helgehaf@aitel.hist.no>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler & interactivity improvements
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3EFC2D08.6000905@aitel.hist.no>
References: <3EFAC408.4020106@aitel.hist.no>
 <5.2.0.9.2.20030627071904.00c890e0@pop.gmx.net>
 <5.2.0.9.2.20030627110106.00cf6068@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:39 PM 6/27/2003 +0200, Helge Hafting wrote:
>Mike Galbraith wrote:
>>At 10:18 AM 6/27/2003 +0200, Helge Hafting wrote:
>[...]
>
> > (simple?  decode stack, find out where he was sleeping,
>Complicated indeed, but why do that?
>A process sleeping on a pipe will wake up in the kernel's
>pipe reading code, won't it?  No need for guessing where
>it was sleeping.  Code for transferring interactivity
>bonus could go right there.

<G> Suggestion:  Re-read the part you snipped before you submit the patch.

>>What I think kills the priority redistribution idea is _massive_ 
>>complexity.  I don't see anything simple.  You would have to build the 
>>logical connections between tasks, which currently doesn't exist.
>
>I must admit I don't know the details of the scheduler.  Still, Linus
>tried a form of redistribution (the backboost thing).  It helped in some 
>cases.
>It seems to me that it got revoked because it did the wrong
>thing at times, leading to starvation issus that didn't exist before.
>It didn't go because it was overly complex or slow?

It went because it drove the system nuts sometimes.  Too bad that, it was 
lovely for GUI.

         -Mike 

