Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUIXNn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUIXNn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268752AbUIXNn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:43:28 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:23630 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268750AbUIXNnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:43:25 -0400
Subject: Re: PATCH: tty ldisc work version 4
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040923054842.GB30650@devserv.devel.redhat.com>
References: <20040922141821.GA27672@devserv.devel.redhat.com>
	 <20040922172139.0d7a1dd3.akpm@osdl.org>
	 <20040923054842.GB30650@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1096033380.4995.6.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 08:43:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 00:48, Alan Cox wrote:
> On Wed, Sep 22, 2004 at 05:21:39PM -0700, Andrew Morton wrote:
> > This gives me "init_dev but no ldisc" when initscripts start playing with
> > the USB keyboard.  The machine then stops.
> 
> Intriguing. Does this go way if you uncomment the lines below
> "Switchg the line discipline back" in tty_io.c.
> 
> I'll stick a USB keyboard on my box later today and chase that down.

Andrew, Alan:

Did this turn out to be related to the code
in release_dev() that switches back a tty struct
back to N_TTY ldisc before freeing the tty struct?

-- 
Paul Fulghum
paulkf@microgate.com

