Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVCIGJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVCIGJl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVCIGJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:09:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:48603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261698AbVCIGIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:08:49 -0500
Date: Tue, 8 Mar 2005 21:50:57 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: linux-kernel@vger.kernel.org, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309055057.GA17287@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E0B3C89A2@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E0B3C89A2@minimail.digi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 08:36:57PM -0600, Kilau, Scott wrote:
> > > 
> > > If you were to open up the port with an "stty -a" to get the current
> 
> > > settings and signals, you would unintentionally raise RTS and DTR.
> >
> > Why not fix the driver to not change the current line settings if it
> is
> > not being opened for the first time?  That seems like a much simpler
> way
> > to solve this, and probably the saner way, as you don't want any user
> to
> > be able to mess up your modem...
> >
> 
> Oh, when the port is already open, the driver correctly would not muck
> with DTR/RTS.
> 
> I am talking about when the port is currently not open.
> 
> On first port open, DTR (and usually RTS) will always be raised.
> The serial device would see this DTR raise, and under some
> circumstances, react to it...

Ok, well, that sounds like something that all serial devices should
support, right?  And if so, why not add this to the serial core for
everyone to benifit?

thanks,

greg k-h
