Return-Path: <linux-kernel-owner+w=401wt.eu-S1751799AbWLNRzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWLNRzc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWLNRzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:55:31 -0500
Received: from mail.suse.de ([195.135.220.2]:45977 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbWLNRzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:55:31 -0500
Date: Thu, 14 Dec 2006 09:54:48 -0800
From: Greg KH <greg@kroah.com>
To: Avi Kivity <avi@argo.co.il>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Userspace I/O driver core
Message-ID: <20061214175448.GA24328@kroah.com>
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il> <1166091570.27217.983.camel@laptopd505.fenrus.org> <45812B83.90006@argo.co.il> <1166093641.27217.989.camel@laptopd505.fenrus.org> <45812DDD.4080907@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45812DDD.4080907@argo.co.il>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 12:56:29PM +0200, Avi Kivity wrote:
> Arjan van de Ven wrote:
> >On Thu, 2006-12-14 at 12:46 +0200, Avi Kivity wrote:
> >  
> >>Arjan van de Ven wrote:
> >>    
> >>>>I understand one still has to write a kernel driver to shut up the irq. 
> >>>>How about writing a small bytecode interpreter to make event than 
> >>>>unnecessary?
> >>>>    
> >>>>        
> >>>if you do that why not do a real driver.
> >>>
> >>>  
> >>>      
> >>An entire driver in bytecode? 
> >>    
> >
> >no a real, non-bytecode driver.
> >
> >  
> 
> Isn't the whole point of uio is to avoid writing a kernel mode driver?

No.  Did you read the documentation that is written about the uio core?

> As proposed, it doesn't quite accomplish it.  With an additional 
> bytecode interpreter, you can have a 100% userspace driver (the bytecode 
> interpreter would be part of uio, not the driver).

If you want to try to work on something as complex as a bytecode
interpreter that can handle all of the hookups to the pci and other
kernel subsystems that are necessary to get such a driver to work
properly, feel free to.

But until then, you'll have to stick with a tiny kernelspace driver that
handles the basic hardware discovery and initialization logic.

Which, for everyone that I have talked to that needs such a driver, is
not a problem at all.

thanks,

greg k-h
