Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWHUWxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWHUWxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWHUWxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:53:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751273AbWHUWxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:53:05 -0400
Date: Mon, 21 Aug 2006 15:52:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpi: ec_transaction(), second try
Message-Id: <20060821155258.21bebc10.akpm@osdl.org>
In-Reply-To: <20060820222759.GA5369@curacao>
References: <20060820222759.GA5369@curacao>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 00:27:59 +0200
Lennart Poettering <mzxreary@0pointer.de> wrote:

> This is the second version of my patch which unifies the logic of
> ec_read() and ec_write() into ec_transaction(). Most things I wrote
> about the first version are still true:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115517205307700&w=2
> 
> The changes are:
> 
> - Updated for Kernel 2.6.18pre (Linus' GIT tree as of today)
> 
> - Fix a bad argument validity check in acpi_ec_poll_transaction() as
>   pointed out by Yu Luming.
> 
> - I unified the code in acpi_ec_poll_transaction() and
>   acpi_ec_intr_transaction() a little more. Both functions are now just
>   wrappers around the new acpi_ec_transaction_unlocked() function. The
>   latter contains the EC access logic, the two original
>   function now just do their special way of locking and call the the
>   new function for the actual work.
> 
> This patch is required for my MSI laptop support patch.
> 
> Based on Linus' GIT tree and should also apply to the current ACPI
> tree. 

This isn't a suitable description of this work.  Please review
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, especially section
4 and then send (and maintain) a new changelog, thanks.

