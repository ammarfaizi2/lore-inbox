Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbUFWA07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUFWA07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 20:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUFWA07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 20:26:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48555 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264044AbUFWA05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 20:26:57 -0400
Message-ID: <40D8CE3F.4010306@pobox.com>
Date: Tue, 22 Jun 2004 20:26:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: long <tlnguyen@snoqualmie.dp.intel.com>, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH]2.6.7 MSI-X Update
References: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com> <52n02vkuy6.fsf@topspin.com>
In-Reply-To: <52n02vkuy6.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> This looks good, a definite improvement over what's currently in the
> kernel.  I do have one question about the whole msi.c file (and this
> applies to the code that's already in the tree, too).  Why is config
> space being accessed via calls like
> 
> 	dev->bus->ops->read(dev->bus, dev->devfn, ... )
> 
> instead of just calling
> 
>         pci_read_config_word(dev, ... )
> 
> The only difference seems to be that MSI is bypassing the locking in
> access.c.  Is there some reason for this?

hmmmmmmm.

Unless it's already inside the lock somehow...  it definitely needs to 
take the lock, one way or another.

	Jeff


