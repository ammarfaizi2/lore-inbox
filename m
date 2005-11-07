Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965324AbVKGUGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbVKGUGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965345AbVKGUGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:06:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:17326 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964901AbVKGUFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:05:50 -0500
Date: Mon, 7 Nov 2005 12:03:52 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7]: PCI revised [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051107200352.GB22524@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107195727.GF19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107195727.GF19593@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:57:27PM -0600, linas wrote:
> On Mon, Nov 07, 2005 at 10:27:27AM -0800, Greg KH was heard to remark:
> > 3) realy strong typing that sparse can detect.
> 
> 
> PCI Error Recovery: header file patch
> 
> Change enums and subroutine signatures to be strongly typed, per recent
> discussion with GregKH. Also, change the acronym to the more unique, 
> less generic "PERS" "PCI Error Recovery System".
> 
> Greg, Please apply.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> --
> Index: linux-2.6.14-mm1/include/linux/pci.h
> ===================================================================
> --- linux-2.6.14-mm1.orig/include/linux/pci.h	2005-11-07 13:55:28.528843983 -0600
> +++ linux-2.6.14-mm1/include/linux/pci.h	2005-11-07 13:55:35.745830682 -0600
> @@ -82,11 +82,11 @@
>   *  the pci device.  If some PCI bus between here and the pci device
>   *  has crashed or locked up, this info is reflected here.
>   */
> -enum pci_channel_state {
> +typedef enum {
>  	pci_channel_io_normal = 0,	/* I/O channel is in normal state */
>  	pci_channel_io_frozen = 1,	/* I/O to channel is blocked */
>  	pci_channel_io_perm_failure,	/* PCI card is dead */
> -};
> +} pci_channel_state_t;

No, this doesn't help out at all.  Please go look at the __bitwise
documentation.

Good luck,

greg k-h
