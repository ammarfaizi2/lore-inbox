Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWG3UpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWG3UpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWG3UpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:45:24 -0400
Received: from ns.suse.de ([195.135.220.2]:40588 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751321AbWG3UpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:45:24 -0400
Date: Sun, 30 Jul 2006 13:41:01 -0700
From: Greg KH <greg@kroah.com>
To: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3 does not like an old udev (071)
Message-ID: <20060730204101.GA21794@kroah.com>
References: <44CCEC96.3020607@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CCEC96.3020607@yahoo.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 07:29:58PM +0200, Guillaume Chazarain wrote:
> Hi,
> 
> When updating only the kernel to 2.6.18-rc3 on Ubuntu Dapper/x86, 
> /dev/usblp0
> is no more created on boot. If I manually create it, it works fine.
> 
> Vanilla udev from Dapper: version 079 (Documentation/Changes requires
> udev 071 ;-) ).
> 
> git-bisect told me the culprit was
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bd00949647ddcea47ce4ea8bb2cfcfc98ebf9f2a
> 
> Reverting only this commit makes an Oopsing kernel.
> 
> This patch was next to last in its serie:
> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg44538.html
> 
> Reverting the last patch in the serie (as well as the culprit found by 
> git bisect):
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43104f1da88f5335e9a45695df92a735ad550dda
> fixes the problem.
> 
> Updating udev to 096, and using a normal 2.6.18-rc3 kernel works too, so 
> maybe
> the correct (albeit unpopular) fix is to update the udev requirement in
> Documentation/Changes?

No, I'm going to revert the above change, as I didn't realize that we
needed a change to udev to support it.  I'll wait until the next major
release for that, and other changes that will require an update to udev
version 081 (released back in January).

But upgrading udev sure doesn't hurt anything :)

thanks,

greg k-h
