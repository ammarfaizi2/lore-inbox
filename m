Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUAaBZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 20:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUAaBZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 20:25:52 -0500
Received: from bolt.sonic.net ([208.201.242.18]:33195 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S262603AbUAaBZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 20:25:49 -0500
Date: Fri, 30 Jan 2004 17:25:46 -0800
From: David Hinds <dhinds@sonic.net>
To: Roger Larsson <roger.larsson@norran.net>
Cc: linux-kernel@vger.kernel.org, joe619017@yahoo.com
Subject: Re: Problems with IDE CF - SMP (PREEMPT)
Message-ID: <20040130172546.A3310@sonic.net>
References: <200401310250.57492.roger.larsson@norran.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401310250.57492.roger.larsson@norran.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 02:50:57AM +0100, Roger Larsson wrote:
> Note that since ide-cs has problems with SMP it will have problems with 
> PREEMPT as well...

This is almost certainly not a problem with the ide-cs driver.

> A now old report...
> http://pcmcia-cs.sourceforge.net/cgi-bin/HyperNews/get/pcmcia/ide/28.html?nogifs

This is not the same problem.

> I have seen problems like this recently (2.4.21) and thought I have
> read this somewhere more recent - but can not find it. I will create
> a bug report.  (Summary: Freezes with SMP, same kernel works with
> option nosmp) Remember that drivers that are not SMP safe won't be
> PREEMPT safe either.

The ide-cs driver is just a teeny wrapper that tells the regular
kernel IDE subsystem to do all the work.  The kernel IDE driver is
presumably SMP safe.

You will have to give much more information to have any hope of
resolving this problem.  My first guess would be that you have a
problem with routing of the PCMCIA bridge interrupt.

- Dave
