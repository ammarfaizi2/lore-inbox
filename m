Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269761AbUINT5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269761AbUINT5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269708AbUINTxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:53:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:35806 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269760AbUINTx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:53:26 -0400
Date: Tue, 14 Sep 2004 12:52:21 -0700
From: Greg KH <greg@kroah.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: "Giacomo A. Catenazzi" <cate@debian.org>, linux-kernel@vger.kernel.org,
       Tigran Aivazian <tigran@veritas.com>
Subject: Re: udev is too slow creating devices
Message-ID: <20040914195221.GA21691@kroah.com>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41474926.8050808@nortelnetworks.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 01:40:22PM -0600, Chris Friesen wrote:
> Giacomo A. Catenazzi wrote:
> 
> >udev + modular microcode:
> >$ modprobe -r microcode
> >$ modprobe microcode ; microcode_ctl -u
> >=> microcode_ctl does NOT find the device
> 
> The loading of the module triggers udev to run.  There is no guarantee that 
> udev runs before microcode_ctl.
> 
> One workaround would be to have microcode_ctl use dnotify to get woken up 
> whenever /dev changes.

Ick, no.  Use the /etc/dev.d/ notify method I described.  That is what
it is there for.

thanks,

greg k-h
