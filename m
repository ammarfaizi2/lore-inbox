Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVF0PCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVF0PCk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVF0O4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:56:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62692 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261986AbVF0NVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:21:18 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Driver writer's guide to sleeping
Date: Mon, 27 Jun 2005 16:20:52 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200506251250.18133.vda@ilport.com.ua> <200506251454.36745.vda@ilport.com.ua> <200506262138.03708.oliver@neukum.org>
In-Reply-To: <200506262138.03708.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506271620.52836.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 22:38, Oliver Neukum wrote:
> Am Samstag, 25. Juni 2005 13:54 schrieb Denis Vlasenko:
> > On Saturday 25 June 2005 14:29, Oliver Neukum wrote:
> > > On Sat, 25 Jun 2005, Denis Vlasenko wrote:
> > > 
> > > > schedule_timeout(timeout)
> > > > 	Whee, it has a comment! :)
> > > >  * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
> > > >  * pass before the routine returns. The routine will return 0
> > [snip]
> > > > 	Thus:
> > > > 	set_current_state(TASK_[UN]INTERRUPTIBLE);
> > > > 	schedule_timeout(timeout_in_jiffies)
> > > > 
> > > > msleep(ms)
> > > > 	Sleeps at least ms msecs.
> > > > 	Equivalent to:
> > > > 	set_current_state(TASK_UNINTERRUPTIBLE);
> > > > 	schedule_timeout(timeout)
> > > 
> > > If and only if you are not on any waitqueue. You may not be interrupted
> > > by a signal, but you still can be woken with an explicit wake_up()
> > 
> > Like this?
> 
> Yes, but we have macros for that. You are supposed to use them.

Erm.. I meant "Shall we correct that comment then, like this?".
Comment is plain wrong now.
--
vda

