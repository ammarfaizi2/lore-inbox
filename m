Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbSKCHzB>; Sun, 3 Nov 2002 02:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSKCHzB>; Sun, 3 Nov 2002 02:55:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32777 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261677AbSKCHzA>;
	Sun, 3 Nov 2002 02:55:00 -0500
Date: Sat, 2 Nov 2002 23:58:06 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Message-ID: <20021103075806.GF25821@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF71@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF71@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 04:56:58PM -0800, Lee, Jung-Ik wrote:
> Hi Greg,
> 
> The following patch changes function scopes only but fixes kernel dump on
> Hot-Add of PCI bridge cards.

Applied, thanks.

Hm, in looking at this, I know the majority of people who want
CONFIG_HOTPLUG probably do not run with CONFIG_PCI_HOTPLUG as the
hardware's still quite rare.  To force those people to keep around all
of the PCI quirks functions and tables after init happens, is a bit
cruel.  I wonder if it's time to start having different subsystems
modify __devinit depending on their config variables.

Does this sound like a good idea?  If so, I can probably knock up
something for the PCI code pretty easily (yes, I'll keep in mind CardBus
stuff, not all hotplug pci is on servers...)

__pci_devinit anyone?  :)

thanks,

greg k-h
