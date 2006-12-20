Return-Path: <linux-kernel-owner+w=401wt.eu-S964888AbWLTUo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWLTUo1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWLTUo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:44:27 -0500
Received: from ns2.suse.de ([195.135.220.15]:54966 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964888AbWLTUo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:44:26 -0500
Date: Wed, 20 Dec 2006 12:43:54 -0800
From: Greg KH <greg@kroah.com>
To: J <jhnlmn@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Possible race condition in usb-serial.c
Message-ID: <20061220204354.GA4039@kroah.com>
References: <200612201047.20842.oliver@neukum.org> <20061220193231.39261.qmail@web32911.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220193231.39261.qmail@web32911.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 11:32:31AM -0800, J wrote:
> Thank you for the explanation.
> 
> > serial_close is safe because serial_disconnect
> > lowers the refcount
> 
> Sorry, I meant serial_open, as in my original example.
> 
> I am currently trying to fix a legacy 2.4 based USB
> driver and I am having various races, 
> serial_open/usb_serial_disconnect is the most lively.
> I am not asking your help in fixing this old 2.4 junk
> (in fact I already fixed it using a global semaphore
> to protect serial_table).

Which usb-serial driver are you having problems with?  What is the oops
trace?  What version of the 2.4 kernel are you using?

And why are you taking the linux-usb-devel list out of the cc:?  :)

thanks,

greg k-h
