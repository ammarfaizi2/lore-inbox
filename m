Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135722AbRDZRTZ>; Thu, 26 Apr 2001 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135723AbRDZRTO>; Thu, 26 Apr 2001 13:19:14 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:312 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S135722AbRDZRS7>; Thu, 26 Apr 2001 13:18:59 -0400
Message-Id: <4.3.2.7.2.20010426100340.00b4ebf0@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 26 Apr 2001 10:16:40 -0700
To: <imel96@trustix.co.id>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: [PATCH] Single user linux
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0104262026140.1816-100000@tessy.trustix.co.i
 d>
In-Reply-To: <Pine.LNX.4.33.0104261423380.1026-100000@grignard.amagerkollegiet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:03 PM 4/26/01 +0700, you wrote:
>right now it's the kernel who thinks that root
>is special, and applications work around that because there's a
>division of super-user and plain user. is that a must?

Short answer:  Yes.

Long answer:  The division is artificial, but is absolutely necessary for 
administration of a Unix-type system.  For example, when the process 
currently running is not running as a "superuser" process, the process 
cannot run resources down to absolute zero -- think disk allocation.  This 
means that the administrator (who may be the same person as the "user") has 
a chance of being able to recover from a runaway process gracefully by 
being able to go in and kill that process before the whole system lays down 
and dies.

Ever watch what happens when Windows runs out of "swap space" because the 
swap file can't get any space?  Ever try to recover from it?  Make damn 
sure you have the non-upgrade CD around when you try this.  Even more 
important, make sure you have multiple back-ups when you try this.

The whole point of "user" and "superuser" is that when the user does 
something stupid or careless or even malicious, the superuser can bail the 
system out.  You don't usually work in superuser mode, and programs that 
don't need superuser access don't get it.

Humans make mistakes a number of orders of magnitude more often than 
computers do.  The barrier helps minimize the damage.

Satch

