Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUIGQ5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUIGQ5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUIGQye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:54:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:31364 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268130AbUIGQuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:50:20 -0400
Date: Tue, 7 Sep 2004 09:45:00 -0700
From: Greg KH <greg@kroah.com>
To: James Morris <jmorris@redhat.com>
Cc: Andreas Happe <andreashappe@flatline.ath.cx>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040907164500.GA8530@kroah.com>
References: <20040906000446.GA16840@kroah.com> <Xine.LNX.4.44.0409071236050.26033-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0409071236050.26033-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 12:37:48PM -0400, James Morris wrote:
> On Sun, 5 Sep 2004, Greg KH wrote:
> 
> > Other than that, I like this move, /proc/crypto isn't the best thing to
> > have in a proc filesystem :)
> 
> The only issue is what to do about potentially expanding this into an API 
> (e.g. open() an algorithm and write to it).  Does this sort of thing 
> belong in sysfs?

No, not really.  That should be in a special fs just for crypto stuff
(cryptofs?)  sysfs is for displaying and setting single units of kernel
information at at time.  So for just showing this crypto information, it
would be fine to use.

thanks,

greg k-h
