Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUGGVSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUGGVSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265495AbUGGVSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:18:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:31118 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265489AbUGGVSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:18:42 -0400
Date: Wed, 7 Jul 2004 14:16:57 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040707211656.GA4105@kroah.com>
References: <20040707155907.G21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707155907.G21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 03:59:07PM -0500, linas@austin.ibm.com wrote:
> +static struct notifier_block eeh_block;
> +
> +void __init init_eeh_handler (void)
> +{
> +	eeh_block.notifier_call = handle_eeh_events;
> +	eeh_register_notifier (&eeh_block);
> +}
> +
> +void __exit exit_eeh_handler (void)
> +{
> +	eeh_block.notifier_call = handle_eeh_events;
> +	eeh_register_notifier (&eeh_block);
> +}
> +

Um, I don't think you want your exit_* function to look identical to
your init_* function :)

greg k-h
