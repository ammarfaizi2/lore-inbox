Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWBQLyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWBQLyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWBQLyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:54:10 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:53901 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751012AbWBQLyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:54:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: suspend console gone ?
Date: Fri, 17 Feb 2006 12:54:44 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
References: <1140141242.3806.2.camel@localhost.localdomain>
In-Reply-To: <1140141242.3806.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171254.45178.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 02:54, Benjamin Herrenschmidt wrote:
> I haven't tried to track this down yet, but with recent 2.6.16-git, it
> seems that the suspend console is gone... That is, the kernel still
> switches VTs from X to some console with no getty on it, but no kernel
> message gets displayed at all during the suspend process... looks like
> this kmsg_redirect thing isn't working.
> 
> Known problem ?

Sort of.  You have to switch the console loglevel to at least 5 before
suspend to see the messages.

The kernel used to switch this to 10 unconditionally before and lots of
debug garbage got printed, especially on -mm.

We considered printing some "crucial" messages (like the progress meter ;-))
at KERN_CRIT, but decided not to do this for now.  We can change this at any
time, if needed.

Greetings,
Rafael
