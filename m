Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269433AbUJFWUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269433AbUJFWUU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269508AbUJFWRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:17:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:35805 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269433AbUJFWQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:16:43 -0400
Date: Thu, 7 Oct 2004 00:13:06 +0200
From: Andi Kleen <ak@suse.de>
To: kernel@suse.de
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: [kernel] Fix random crashes in x86-64 swsusp
Message-ID: <20041006221306.GB7456@wotan.suse.de>
References: <200410052314.25253.rjw@sisk.pl> <200410061206.56025.rjw@sisk.pl> <20041006101238.GD1255@elf.ucw.cz> <200410062346.29489.rjw@sisk.pl> <20041006220600.GB25059@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006220600.GB25059@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 12:06:00AM +0200, Pavel Machek wrote:
> Hi!
> 
> fix_processor_context was calling functions marked __init on x86-64;
> bad idea. Maybe we should memset freed memory to zero so such bugs are
> prevented?

It's called CONFIG_INIT_DEBUG. But nobody uses it.

-Andi

