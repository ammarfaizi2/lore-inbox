Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUINVim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUINVim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269231AbUINVgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:36:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:52378 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269247AbUINVfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:35:54 -0400
Date: Tue, 14 Sep 2004 14:35:06 -0700
From: Greg KH <greg@kroah.com>
To: "Giacomo A. Catenazzi" <cate@pixelized.ch>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Giacomo A. Catenazzi" <cate@debian.org>, linux-kernel@vger.kernel.org,
       Tigran Aivazian <tigran@veritas.com>, md@Linux.IT
Subject: Re: udev is too slow creating devices
Message-ID: <20040914213506.GA22637@kroah.com>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414757FD.5050209@pixelized.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 10:43:41PM +0200, Giacomo A. Catenazzi wrote:
> The "bug" appear only in two places: at udev start and after
> a modprobe, so IMHO we should correct these two place, so that:
> - from a user side perspective it is the right thing!
>   (after a successful modprobe, I expect module and devices
>    are created sussesfully)

That "expectation" is incorrect.  The device node will show up any time
after modprobe has started, just because modprobe returns does not mean
the device node is present.

> - there are not many special case:
>   with udev use dev.d, else do actions now!

I don't understand what you are proposing.

> Else every distribution should create a script for
> every init.d script that would eventually use (also
> indirectly) a kernel module.

What's wrong with the /etc/dev.d/ location for any type of script that
you want to run after a device node has appeared?  This is an
application specific issue, not a kernel issue.

thanks,

greg k-h
