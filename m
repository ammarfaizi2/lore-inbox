Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVALTM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVALTM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVALTJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:09:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:44701 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261326AbVALTGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:06:25 -0500
Date: Wed, 12 Jan 2005 11:03:19 -0800
From: Greg KH <greg@kroah.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel conector. Reincarnation #1.
Message-ID: <20050112190319.GA10885@kroah.com>
References: <1101286481.18807.66.camel@uganda> <1101287606.18807.75.camel@uganda> <20041124222857.GG3584@kroah.com> <1102504677.3363.55.camel@uganda> <20041221204101.GA9831@kroah.com> <1103707272.3432.6.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103707272.3432.6.camel@uganda>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 12:21:12PM +0300, Evgeniy Polyakov wrote:
> Hello, Greg, developers.
> 
> This is first public resending of connector patch after several private
> discussions.
> Noone objected before, so if there are no complaints, Greg, please
> apply.

one minor issue:

> +#include "../connector/connector.h"

Shouldn't connector.h go into include/linux so that everyone can use it
within the kernel?  If so, then it's dependancy on cn_queue.h needs to
be fixed up too (why not just merge them both together)?

> +#include "../connector/cn_queue.h"

This can just be:
	#include "cn_queue.h"
if you end up still needing it.


Sorry for taking so long to get back to this, was on vacation.

thanks,

greg k-h
