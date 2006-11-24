Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965753AbWKXRd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965753AbWKXRd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 12:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934996AbWKXRdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 12:33:55 -0500
Received: from ns.suse.de ([195.135.220.2]:54720 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S934998AbWKXRdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 12:33:53 -0500
From: Andi Kleen <ak@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] efi_limit_regions triggers link failure when CONFIG_EFI is not defined
Date: Fri, 24 Nov 2006 18:33:47 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>,
       Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>,
       linux-kernel@vger.kernel.org
References: <20061123021703.8550e37e.akpm@osdl.org> <200611241805.45621.ak@suse.de> <45672AC8.2010303@shadowen.org>
In-Reply-To: <45672AC8.2010303@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241833.47671.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Compiler is as below:
> 
>     gcc version 3.3.4 (Debian 1:3.3.4-3)

Ah, pre unit-at-a-time and some other quirks too. Hopefully
at some point we can unsupport it.

> Yes, making efi_limit_regions() inline also seems to work. 

Ok i will make it so.

> Can we 
> guarentee it will be inlined though?  I had the feeling that inline was
> advisory and if it does not inline then we will get the link failures.

It's defined to __attribute__((always_inline)) inline

-Andi

