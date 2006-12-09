Return-Path: <linux-kernel-owner+w=401wt.eu-S1030190AbWLIMzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWLIMzP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031640AbWLIMzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:55:15 -0500
Received: from postel.suug.ch ([194.88.212.233]:36774 "EHLO postel.suug.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030190AbWLIMzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:55:13 -0500
Date: Sat, 9 Dec 2006 13:55:33 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Stefan Rompf <stefan@loplof.de>
Cc: David Miller <davem@davemloft.net>, drow@false.org, dwmw2@infradead.org,
       joseph@codesourcery.com, netdev@vger.kernel.org,
       libc-alpha@sourceware.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [NETLINK]: Schedule removal of old macros exported to userspace
Message-ID: <20061209125533.GO8693@postel.suug.ch>
References: <20061208.134752.131916271.davem@davemloft.net> <20061208.171455.11932070.davem@davemloft.net> <20061209103953.GN8693@postel.suug.ch> <200612091249.39302.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612091249.39302.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Rompf <stefan@loplof.de> 2006-12-09 12:49
> Am Samstag, 9. Dezember 2006 11:39 schrieb Thomas Graf:
> 
> [Added linux-kernel to CC]
> 
> > Index: net-2.6/Documentation/feature-removal-schedule.txt
> > ===================================================================
> > --- net-2.6.orig/Documentation/feature-removal-schedule.txt	2006-12-09
> 
> NAK.
> 
> > +What:  Netlink message and attribute parsing macros
> > +When:  July 2007
> > +Why:   The old interface which often lead to buggy code has been replaced
> > +       with a new type safe interface. Parts of this interface, mainly
> > +       macros, has been exported to userspace via linux/netlink.h and
> > +       linux/rtnetlink.h. Use of this interface is discontinued, all
> > helper +       and utility macros will be removed. Userspace applications
> > should use +       one of the available libraries.
> > +Who:   Thomas Graf <tgraf@suug.ch>
> 
> So glibc should be linked to libnl that depends on glibc to compile? Be 
> serious!

Please calm down a bit. I didn't claim that glibc should be linking to
libnl. glibc is obviously a special case which can simply copy the existing
macros into some internal compat header just like any other application
that doesn't wish to use any of the libraries available.

The point is to stop new applications from using the interface which has
resulted in buggy code in the past.
