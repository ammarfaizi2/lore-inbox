Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbUJ1QJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbUJ1QJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUJ1QJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:09:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:41950 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261824AbUJ1QG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:06:59 -0400
Date: Thu, 28 Oct 2004 11:06:03 -0500
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: [PATCH] Fix e100 suspend/resume w/ 2.6.10-rc1 and above (due to pci_save_state change)
Message-ID: <20041028160603.GA10538@kroah.com>
References: <20041028025536.5d9b1067.akpm@osdl.org> <41810066.5000705@pobox.com> <20041028142956.GA9400@kroah.com> <4181094D.7020800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4181094D.7020800@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 10:59:25AM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >Huh?  How did changing the pci_save_state() api change anything?  I
> >didn't change the pci core any, just made it easier to not have to
> >specify the storage location of the memory to save everything off on.
> 
> That could have been accomplished by moving the saved-config data 
> storage into struct pci_dev

We did that a while ago.

> but not changing pci_save_state() prototype...

That was the last piece.  It also fixed up some odd bugs when it was
done.

Do we really want drivers to go back to have to declare the pci config
space themselves if they want to?  What does that buy us?

I agree that Ben's comments are valid, but the recent patch doesn't
change anything that wasn't already being done.

thanks,

greg k-h
