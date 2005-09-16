Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVIPWY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVIPWY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVIPWY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:24:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44210 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750725AbVIPWY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:24:58 -0400
Date: Fri, 16 Sep 2005 15:24:32 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: alan@lxorguk.ukuu.org.uk, dtor_core@ameritech.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, caphrim007@gmail.com, david-b@pacbell.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Lost keyboard on Inspiron 8200 at 2.6.13
Message-Id: <20050916152432.5a05aeca.zaitcev@redhat.com>
In-Reply-To: <20050916184440.GA11413@kroah.com>
References: <432A4A1F.3040308@gmail.com>
	<200509152357.58921.dtor_core@ameritech.net>
	<20050916025356.0d5189a6.akpm@osdl.org>
	<d120d500050916082519c660e6@mail.gmail.com>
	<1126886449.17038.4.camel@localhost.localdomain>
	<20050916184440.GA11413@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005 11:44:40 -0700, Greg KH <greg@kroah.com> wrote:
> On Fri, Sep 16, 2005 at 05:00:49PM +0100, Alan Cox wrote:
> > On Gwe, 2005-09-16 at 10:25 -0500, Dmitry Torokhov wrote:

> Only if we merge the code that does the handoff, with the same code that
> does it in the usb core, would I feel more comfortable to enable this
> always.  I had a patch from David Brownell to do this, but it had some
> link errors at times, so I had to drop it :(

I see why you would want to merge them, but is it worth the trouble?
They are not identical. For one thing, early handoff installs its own
fake interrupt handlers (Alan Cox insisted on it in the RHEL
implementation).

I'd like to see handoff done by default, too. If you make it predicated
on the merge, so be it.

-- Pete
