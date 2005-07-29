Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVG2AqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVG2AqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVG2AqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:46:01 -0400
Received: from farley.sventech.com ([69.36.241.87]:36070 "EHLO
	mail.sventech.com") by vger.kernel.org with ESMTP id S261874AbVG2Ap7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:45:59 -0400
Date: Thu, 28 Jul 2005 17:45:58 -0700
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Linux 2.4.32-pre2
Message-ID: <20050729004558.GD4817@sventech.com>
References: <20050727080512.GD7368@dmt.cnet> <2i7he1lgg2237n66ec5p3e007tdsjos531@4ax.com> <20050728102225.GA7661@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728102225.GA7661@dmt.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> diff --git a/drivers/usb/host/uhci.c b/drivers/usb/host/uhci.c
> --- a/drivers/usb/host/uhci.c
> +++ b/drivers/usb/host/uhci.c
> @@ -2924,7 +2924,7 @@ static int alloc_uhci(struct pci_dev *de
>  		}
>  
>  		/* Only place we don't use the frame list routines */
> -		uhci->fl->frame[i] =  uhci->skeltd[irq]->dma_handle;
> +		uhci->fl->frame[i] = uhci->skeltd[irq]->dma_handle | UHCI_PTR_QH;
>  	}
>  
>  	start_hc(uhci);

Am I missing something here? We're certainly adding TDs to the schedule, so
why is this patch setting the QH bit?

JE

