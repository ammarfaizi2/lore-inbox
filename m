Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVFZTl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVFZTl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVFZTl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:41:58 -0400
Received: from mail1.kontent.de ([81.88.34.36]:32702 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261583AbVFZTh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:37:56 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [RFC] Driver writer's guide to sleeping
Date: Sun, 26 Jun 2005 21:38:03 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200506251250.18133.vda@ilport.com.ua> <Pine.LNX.4.58.0506251327390.3206@fachschaft.cup.uni-muenchen.de> <200506251454.36745.vda@ilport.com.ua>
In-Reply-To: <200506251454.36745.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506262138.03708.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 25. Juni 2005 13:54 schrieb Denis Vlasenko:
> On Saturday 25 June 2005 14:29, Oliver Neukum wrote:
> > On Sat, 25 Jun 2005, Denis Vlasenko wrote:
> > 
> > > schedule_timeout(timeout)
> > > 	Whee, it has a comment! :)
> > >  * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
> > >  * pass before the routine returns. The routine will return 0
> [snip]
> > > 	Thus:
> > > 	set_current_state(TASK_[UN]INTERRUPTIBLE);
> > > 	schedule_timeout(timeout_in_jiffies)
> > > 
> > > msleep(ms)
> > > 	Sleeps at least ms msecs.
> > > 	Equivalent to:
> > > 	set_current_state(TASK_UNINTERRUPTIBLE);
> > > 	schedule_timeout(timeout)
> > 
> > If and only if you are not on any waitqueue. You may not be interrupted
> > by a signal, but you still can be woken with an explicit wake_up()
> 
> Like this?

Yes, but we have macros for that. You are supposed to use them.

	Regards
		Oliver
