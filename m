Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTI2TJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTI2TJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:09:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:19150 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264503AbTI2TJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:09:26 -0400
Date: Mon, 29 Sep 2003 12:09:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Bradley Chapman <kakadu_croc@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
Message-ID: <20030929120910.A6895@osdlab.pdx.osdl.net>
References: <20030929155042.53666.qmail@web40910.mail.yahoo.com> <20030929094136.0b4bb026.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030929094136.0b4bb026.akpm@osdl.org>; from akpm@osdl.org on Mon, Sep 29, 2003 at 09:41:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> >
> > I am experiencing defunct event/0 kernel daemons under 2.6.0-test6-mm1
> >  with synaptics_drv 0.11.7, Dmitry Torokhov's gpm-1.20 with synaptics
> >  support, and XFree86 4.3.0-10. Moving the touchpad in either X or with
> >  gpm causes defunct event/0 processes to be created. 
> 
> Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?
> 
> You could try reverting synaptics-reconnect.patch, and then serio-reconnect.patch from

Andrew, I wonder if this isn't caused by the call_usermodehelper patch.
Looks like you were right ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
