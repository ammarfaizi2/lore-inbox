Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVCXSXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVCXSXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbVCXSXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:23:41 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:24450 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261270AbVCXSXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:23:34 -0500
From: David Brownell <david-b@pacbell.net>
To: Jakemuksen spammiosote <jhroska@byterapers.com>
Subject: Re: [PATCH] usbnet.c, buf.overrun crash-bugfix, Kernel 2.6.12-rc1
Date: Thu, 24 Mar 2005 10:23:26 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503241722160.30661@byterapers.com> <200503240857.28594.david-b@pacbell.net> <Pine.LNX.4.61.0503242006160.767@byterapers.com>
In-Reply-To: <Pine.LNX.4.61.0503242006160.767@byterapers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503241023.26308.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 March 2005 10:13 am, Jakemuksen spammiosote wrote:
> On Thu, 24 Mar 2005, David Brownell wrote:
> > On Thursday 24 March 2005 8:05 am, Jakemuksen spammiosote wrote:
> 
> >> +       if (unlikely((skb->tail + urb->actual_length) > skb->end)) {
> > 
> > This logic looks wrong.  If that ever happens, surely the problem is 
> > that the rx_submit() code submitted an urb with transfer_size that
> > mismatched the SKB.  The host controller isn't allowed to overrun the
> 
> Sounds reasonable. So, I'll go thru the HCD code

Better yet, start with the code supporting that device you're
under NDA for.


> instead if the  
> responsibility is there. Am i the first one to run into such crash 
> situation? If so, perhaps it's not ever worthy to fix in mainstream 
> kernel, as the device causes the crash under very specific - 
> 'abusing' one might say, situation only.

You're the first one to report such a problem.

- Dave
