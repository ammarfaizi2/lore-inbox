Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbULIOF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbULIOF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbULIOF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:05:56 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:4824 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261338AbULIOFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:05:52 -0500
Date: Thu, 9 Dec 2004 15:05:50 +0100
From: bert hubert <ahu@ds9a.nl>
To: Hsu I-Chieh <ejhsu@msn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't call function provided by kernel
Message-ID: <20041209140550.GA8230@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Hsu I-Chieh <ejhsu@msn.com>, linux-kernel@vger.kernel.org
References: <BAY5-F186433AE314D0B1687EDC0A4B70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY5-F186433AE314D0B1687EDC0A4B70@phx.gbl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 08:09:08AM +0000, Hsu I-Chieh wrote:

> I'm writing a kernel module in kernel 2.6.x. I called
> local_flush_tlb_all() in my module and there is no error or warning during
> compiling time. The code fragment is as follow:

The problem is probably that local_flush_tlb_all() is not exported. It
appears to only be exported on IA64.

In fact, it appears the entire function does not exist on all that many
architectures!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
