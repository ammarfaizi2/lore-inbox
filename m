Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbVJTPDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbVJTPDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbVJTPDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:03:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5619 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S1751560AbVJTPDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:03:09 -0400
Date: Thu, 20 Oct 2005 08:02:26 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       ganzinger@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <Pine.LNX.4.58.0510200238390.27683@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0510200759110.19738@dhcp153.mvista.com>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <Pine.LNX.4.64.0510190816380.30406@dhcp153.mvista.com>
 <Pine.LNX.4.58.0510200238390.27683@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2005, Steven Rostedt wrote:
>
> Yes, but that shouldn't make a difference.  NTP can slow down or speed up
> the clock, but it should never make it go backwards. Especially for a
> monotonic clock (as the name suggests).

 	It looks like if ntp_adj held a big negative number you might end 
up with a smaller output . ntp_adj is signed too .. I don't know how 
ntp_adj is set though .

 	I thought I remember George Anzinger speculating that ntp could 
cause the time to backwards , that's why I brought it up. Maybe if he's 
read he can clue us in ..

Daniel
