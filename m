Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWAEOkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWAEOkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAEOkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:40:14 -0500
Received: from cabal.ca ([134.117.69.58]:7907 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1751372AbWAEOkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:40:08 -0500
Date: Thu, 5 Jan 2006 09:39:29 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060105143929.GA8978@quicksilver.road.mcmartin.ca>
References: <20060105045212.GA15789@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105045212.GA15789@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 11:52:12PM -0500, Dave Jones wrote:
>  	printk("\n");
> +	{
> +		int i;
> +		for (i=120;i>0;i--) {
> +			mdelay(1000);
> +			touch_nmi_watchdog();
> +			printk("Continuing in %d seconds. \r", i);
> +		}
> +		printk("\n");
> +	}
>

Nice, this is cool. Though, perhaps it would be better if the loop length
was a command line argument like with panic_timeout? 

Cheers,
	Kyle
