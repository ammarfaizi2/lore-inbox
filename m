Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754743AbWKMOLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbWKMOLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbWKMOLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:11:55 -0500
Received: from ns.suse.de ([195.135.220.2]:53214 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754743AbWKMOLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:11:54 -0500
To: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Satt, Shai" <shai.satt@intel.com>
Subject: Re: [PATCH 2.6.19-rc5-git2]  EFI: mapping memory region of runtime services when using memmap kernel parameter
References: <C1467C8B168BCF40ACEC2324C1A2B0740170445A@hasmsx411.ger.corp.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2006 15:11:52 +0100
In-Reply-To: <C1467C8B168BCF40ACEC2324C1A2B0740170445A@hasmsx411.ger.corp.intel.com>
Message-ID: <p73u013307r.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com> writes:
>  
> +extern int is_available_memory(efi_memory_desc_t * md);

Never put externs into .c files

The whole approach of including the run time services into
the memory map seems bogus. How about ioremap()ing (or fixmaping) them
on demand instead?

-Andi
