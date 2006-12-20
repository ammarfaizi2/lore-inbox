Return-Path: <linux-kernel-owner+w=401wt.eu-S1030417AbWLTWxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWLTWxW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160997AbWLTWxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:53:22 -0500
Received: from cantor2.suse.de ([195.135.220.15]:35315 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030417AbWLTWxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:53:22 -0500
Date: Wed, 20 Dec 2006 14:52:53 -0800
From: Greg KH <greg@kroah.com>
To: J <jhnlmn@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Possible race condition in usb-serial.c
Message-ID: <20061220225253.GB12877@kroah.com>
References: <20061220204354.GA4039@kroah.com> <718383.57861.qm@web32914.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <718383.57861.qm@web32914.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 02:39:39PM -0800, J wrote:
> Thank you for your reply.
> 
> > Which usb-serial driver are you having problems
> > with?  What is the oops trace?  
> > What version of the 2.4 kernel are you using?
> 
> I was told to fix an old embedded device, which my
> company bought from somebody many years ago. 
> It appears to have kernel 2.4.9 and a patched version
> of visor.c.

Ugh, old versions of the visor driver had lots of races on the
disconnect path.  Good luck trying to fix all of them, it took until the
2.6 kernel to get all of the reported oopses fixed.

greg k-h
