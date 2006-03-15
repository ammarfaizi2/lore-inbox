Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWCOXz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWCOXz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbWCOXz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:55:57 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4508 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751735AbWCOXz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:55:56 -0500
Date: Wed, 15 Mar 2006 15:55:45 -0800
From: Greg KH <gregkh@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, maule@sgi.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060315235544.GA6504@suse.de>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <44176502.9050109@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44176502.9050109@ce.jp.nec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 07:51:14PM -0500, Jun'ichi Nomura wrote:
> Hi Andrew,
> 
> Andrew Morton wrote:
> >One option might be to create inclued/linux/msi.h, put this declaration in
> >there then include <asm/msi.h>.  Possibly some other declarations should be
> >moved into linux/msi.h as well.
> 
> How about the attached one?
> Build tested on ia64 with both CONFIG_PCI_MSI y and n.

No, we don't need a linux/msi.h, these are core pci things that no one
else should care about.  The other arches handle this just fine, let's
not mess everything up just because ia64 can't get it right :)

thanks,

greg k-h
