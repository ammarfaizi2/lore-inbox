Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269670AbTGOU5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269677AbTGOU5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:57:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:38876 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269670AbTGOU5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:57:41 -0400
Date: Tue, 15 Jul 2003 14:12:45 -0700
From: Greg KH <greg@kroah.com>
To: crozierm@consumption.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse "hang" with 2.5.75
Message-ID: <20030715211245.GA5435@kroah.com>
References: <Pine.LNX.4.21.0307141151520.3036-100000@consumption.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0307141151520.3036-100000@consumption.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 01:59:17PM -0700, crozierm@consumption.net wrote:
> 
> Hello,
> 
> I'm experiencing odd USB mouse behaviour with 2.5.75 & 2.6.0-test1.  Those
> are the only 2.5.x flavors I've used on this particular computer, so I
> don't know if this is something new.

Does the same thing happen on 2.4.21?

> While using the mouse normally, it will suddenly stop responding.  If I
> cat /dev/input/mice and wiggle the mouse, nothing is returned.  No
> extra debug messages appear in the syslog until I unplug the mouse and
> plug it back it, at which point everything works normally.  I can't
> find specific steps to reproduce it, but with persistent use I can
> usually get it to hang up within a minute or two.

Can you enable CONFIG_USB_DEBUG?

> Also, if I leave XFree86 and go to the console, then switch back to
> XFree86, the mouse is restored.  Because of this I thought it must be X,
> but this has never happened with 2.4.x.

Hm, yeah, this looks like an X issue :)

Unless by enabling that config option, you get some information
otherwise...

thanks,

greg k-h
