Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVIAAZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVIAAZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVIAAZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:25:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:5275 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964997AbVIAAZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:25:25 -0400
Date: Wed, 31 Aug 2005 14:43:34 -0700
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tom.l.nguyen@intel.com,
       akpm <akpm@osdl.org>
Subject: Re: [RFC/PATCH]reconfigure MSI registers after resume
Message-ID: <20050831214334.GF20443@kroah.com>
References: <1124343346.6272.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124343346.6272.8.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 01:35:46PM +0800, Shaohua Li wrote:
> Hi,
> It appears pci_enable_msi doesn't reconfigure msi registers if it
> successfully look up a msi for a device. It assumes the data and address
> registers unchanged after calling pci_disable_msi. But this isn't always
> true, such as in a suspend/resume circle. In my test system, the
> registers unsurprised become zero after a S3 resume. This patch fixes my
> problem, please look at it. MSIX might have the same issue, but I
> haven't taken a close look.

Tom, any comments on this?

thanks,

greg k-h
