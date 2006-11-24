Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757803AbWKXRFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757803AbWKXRFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 12:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757804AbWKXRFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 12:05:54 -0500
Received: from ns.suse.de ([195.135.220.2]:54712 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1757801AbWKXRFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 12:05:54 -0500
From: Andi Kleen <ak@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] efi_limit_regions triggers link failure when CONFIG_EFI is not defined
Date: Fri, 24 Nov 2006 18:05:45 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>,
       Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>,
       linux-kernel@vger.kernel.org
References: <20061123021703.8550e37e.akpm@osdl.org> <35d909969a9b883d8ee15ee1df497fd9@pinky>
In-Reply-To: <35d909969a9b883d8ee15ee1df497fd9@pinky>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241805.45621.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 November 2006 17:59, Andy Whitcroft wrote:
> The following patch is needed to get 2.6.19-rc6-mm1 to compile with
> CONFIG_EFI disabled.  This is the 'shortest' fix.  However, it does
> appear that there is some overlap with EFI implmentation partly
> being in e820.c and partly in efi.c.  It might make sense to move
> everything efi related over to efi.c.

It compiles here. And the ifdef status hasn't changed at all.

Ah maybe your compiler failed to inline the function so the compiler
couldn't optimize it away. What compiler were you using? Does it
go away if you add a "inline" to efi_limit_regions()?

-Andi

