Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263570AbUJ2VEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbUJ2VEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbUJ2VDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:03:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:38849 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263573AbUJ2Uzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:55:52 -0400
Date: Fri, 29 Oct 2004 15:43:25 -0500
From: Greg KH <greg@kroah.com>
To: Mehulkumar J Patel <mehul.patel@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exclusive access to hardware for test purpose
Message-ID: <20041029204325.GA30638@kroah.com>
References: <OF2D431ED5.0E0040F4-ON65256F3B.0074805E-65256F3B.007703B3@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2D431ED5.0E0040F4-ON65256F3B.0074805E-65256F3B.007703B3@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 03:05:59AM +0530, Mehulkumar J Patel wrote:
> Hi,
> 
> Is anyone aware of kernel call which allows a test tool developer to have 
> exclusive access to PCI adapter hardware. By exclusive access I mean both
> driver as well as kernel should not touch hardware. 

You need to disconnect the device from any current driver that might be
bound to it.  Then you need to bind to the device to make sure that no
one else binds to it.

> I have been using driver's remove call to simulate the situation as if 
> adapter has been hot plugged out. And once my testing is done I call 
> driver's probe
> call to put adapter back. But this seems to create a problem when somehow 
> kernel calls driver's remove call.

What kind of problem happens?  Any code you can point us at?

thanks,

greg k-h
