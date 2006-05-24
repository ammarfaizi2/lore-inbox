Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWEXQGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWEXQGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWEXQGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:06:09 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:56535 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932321AbWEXQGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:06:08 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sven-Thorsten Dietrich <sven@mvista.com>, tglx@linutronix.de,
       Yann.LEPROVOST@wavecom.fr, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148485943.24623.54.camel@localhost.localdomain>
References: <OFD8B7556E.13DD6F3A-ONC1257178.002C2D9A-C1257178.002D1FC5@wavecom.fr>
	 <1148475334.24623.45.camel@localhost.localdomain>
	 <1148476383.5239.54.camel@localhost.localdomain>
	 <1148484729.14683.5.camel@localhost.localdomain>
	 <1148485943.24623.54.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 May 2006 09:06:03 -0700
Message-Id: <1148486764.3535.145.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Would IRQs stay masked until the thread has finished running?
> 
> I would say yes.  But the system is basically broken if you have the
> same interrupt line that needs both to be threaded and NODELAY.

It's certainly less than and ideal situation .. If set an interrupt as
SA_NODELAY you'd think that it's suppose to be high priority , but then
you share it with something that's not high high priority which doesn't
make a lot of sense ..

However, the PCI bus doesn't (as far as I know) allow for interrupts to
easily be isolated .. So, with PCI, you may end up with potentially high
priority interrupts shared with some other interrupt .. So it is a
situation that could happen, maybe even often .

Daniel

