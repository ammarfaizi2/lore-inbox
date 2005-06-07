Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVFGFWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVFGFWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVFGFWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:22:25 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:2150 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261723AbVFGFWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:22:11 -0400
Date: Mon, 6 Jun 2005 22:22:03 -0700
From: Greg KH <gregkh@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: Dave Jones <davej@redhat.com>, Grant Grundler <grundler@parisc-linux.org>,
       tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050607052202.GD17734@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de> <20050604070537.GB8230@colo.lackof.org> <20050604071803.GA13684@suse.de> <20050604072348.GA28293@redhat.com> <20050606230118.GD11184@suse.de> <5264wrj9l3.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5264wrj9l3.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 05:26:32PM -0700, Roland Dreier wrote:
> 
>     davej> What if MSI support has been disabled in the bridge due to
>     davej> some quirk (like the recent AMD 8111 quirk) ?  Maybe the
>     davej> above function should check pci_msi_enable as well ?
> 
>     Greg> Yes, you are correct.  I said it wasn't tested :)
> 
> Huh?  If a host bridge doesn't support MSI, and a device below it has
> its MSI capability enabled, we're in big trouble.  Because that device
> is going to send interrupt messages whether the bridge likes it or
> not.

No, that device would never get MSI enabled on it.  See the patch I
posted to make sure I didn't get it wrong...

thanks,

greg k-h
