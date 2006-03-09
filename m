Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752005AbWCIX3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbWCIX3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCIX3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:29:05 -0500
Received: from mx.pathscale.com ([64.160.42.68]:6278 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751972AbWCIX3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:29:03 -0500
Subject: Re: [PATCH 7 of 20] ipath - misc driver support code
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adau0a7fbzf.fsf@cisco.com>
References: <2f16f504dd4b98c2ce7c.1141922820@localhost.localdomain>
	 <adau0a7fbzf.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:29:02 -0800
Message-Id: <1141946942.10693.36.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:13 -0800, Roland Dreier wrote:

> This is kind of theoritical, but it seems to me that it would be safer
> to write this as
> 
> 	int ipath_unordered_wc(void)
> 	{
> 		return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
> 	}
> 
> after all, Via is probably going to have an x86-64 CPU one of these
> days, and I doubt you've checked that their WC flush is ordered.

It's purely a performance optimisation.  Since we tune very closely to
each CPU, there's no point right now in sort-of-tuning for a CPU that
doesn't yet exist :-)

	<b

