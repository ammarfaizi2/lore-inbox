Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267227AbUBMVfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267228AbUBMVf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:35:26 -0500
Received: from [66.35.79.110] ([66.35.79.110]:28835 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267227AbUBMVey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:34:54 -0500
Date: Fri, 13 Feb 2004 13:34:45 -0800
From: Tim Hockin <thockin@hockin.org>
To: RANDAZZO@ddc-web.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: spinlocks dont work
Message-ID: <20040213213445.GA23759@hockin.org>
References: <89760D3F308BD41183B000508BAFAC4104B16F74@DDCNYNTD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F74@DDCNYNTD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 04:12:08PM -0500, RANDAZZO@ddc-web.com wrote:
> On a uniprocessor system, with config_smp NOT Defined...
> 
> Note the following example:
> 
> driver 'A' calls spin_lock_irqsave and gets through (but does not call
> ..unlock).
> driver 'B' calls spin_lock_irqsave and gets through???
> 
> How can B get through if A did not unlock yet?

Because actual mutexing is a no-op without CONFIG_SMP.  What you have is a BUG.
Don't do that.


