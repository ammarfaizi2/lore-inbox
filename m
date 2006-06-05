Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751227AbWFERGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWFERGo (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWFERGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:06:44 -0400
Received: from mga07.intel.com ([143.182.124.22]:32622 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751227AbWFERGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:06:44 -0400
X-IronPort-AV: i="4.05,211,1146466800"; 
   d="scan'208"; a="46230361:sNHT4218441101"
Date: Mon, 5 Jun 2006 09:37:01 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 8/9] PCI PM: clear IO and MEM when disabling a device
Message-ID: <20060605093700.A10278@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <1149497176.7831.162.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1149497176.7831.162.camel@localhost.localdomain>; from abelay@novell.com on Mon, Jun 05, 2006 at 04:46:16AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 04:46:16AM -0400, Adam Belay wrote:
> This patch modifies pci_disable_device() to clear IO and MEM from the
> COMMAND PCI config register.  This is required before entering D3,  but
> also probably a good general practice for system suspend.
> 
I'd submitted a patch to do this about a month ago, see
http://marc.theaimsgroup.com/?l=linux-pci&m=114669552428309&w=2

That patch does the same thing, but in arch specific code (since
that's where memory and IO decode get enabled today). This patch
will cover the other arch's too, so I'm fine with this if this
is the right thing to do. My original patch is already in Greg's
tree and needs to be removed if this patch is accepted.

thanks,
Rajesh
