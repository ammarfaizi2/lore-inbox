Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWCGSMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWCGSMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWCGSMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:12:53 -0500
Received: from hera.kernel.org ([140.211.167.34]:4314 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751302AbWCGSMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:12:52 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: What is this: skge Ram read/write data parity error
Date: Tue, 7 Mar 2006 10:12:39 -0800
Organization: OSDL
Message-ID: <20060307101239.5de16cce@localhost.localdomain>
References: <440DA96B.5010604@isotton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1141755158 5073 10.8.0.54 (7 Mar 2006 18:12:38 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 7 Mar 2006 18:12:38 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2006 16:40:27 +0100
Aaron Isotton <aaron@isotton.com> wrote:

> Hello,
> 
> Since some time I'm getting the following log entries under 2.6.15:
> 
> Mar  7 05:42:48 tiger kernel: skge Ram write data parity error
> Mar  7 05:42:48 tiger kernel: skge Ram read data parity error
> 
> Does this mean my hardware is faulty? The error message seems to imply
> that, but since I am not experiencing any problems and a comment in
> skge.c says
> 
> /* Parity errors seem to happen when Genesis is connected to a switch
>  * with no other ports present. Heartbeat error??
>  */
> 
> talking about some other sort of parity error though ("mac parity") I'm
> not sure any more. Can anybody enlighten me?	


Which exact hardware is that, look for the skge line in the kernel log (dmesg)?

I am not a hardware wizard, but I wrote that comment. My guess is that it shows
up when the hardware decides to clock in some data that isn't really a packet
(line noise, etc). Both skge and sk98lin just clear the error and keep going.

Does it happen a lot or just once?
