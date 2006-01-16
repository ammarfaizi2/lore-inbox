Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWAPM03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWAPM03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWAPM03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:26:29 -0500
Received: from cantor2.suse.de ([195.135.220.15]:15524 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750702AbWAPM01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:26:27 -0500
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 0/3] changes about Call Trace:
Date: Mon, 16 Jan 2006 13:22:11 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060116121611.GA539@miraclelinux.com>
In-Reply-To: <20060116121611.GA539@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601161322.12209.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 13:16, Akinobu Mita wrote:
> If I'm missing something, please let me know.
> 
> a) On x86-64 we get different Call Trace format than other architectures
>    when we get oops or press SysRq-t:
> 
>    <ffffffffa008ef6c>{:jbd:kjournald+1030}
> 
>    There is a architecture independent function print_symbol().
>    How about using it on x86-64? But it changes to:
> 
>    [<ffffffffa008ef6c>] kjournald+0x406/0x578 [jbd]

The x86-64 format is more compact.

> b) I can't find useful usage for the symbol size in print_symbol().
>    And symbolsize seems to be fixed when vmlinux or modules are compiled.
>    So we can calculate it from vmlinux or modules.
>    How about removing the field of symbolsize in print_symbol()?
> 
>    [<ffffffffa008ef6c>] kjournald+0x406 [jbd]

It's a double check that the oops is matching the vmlinux you're looking 
at.

-Andi

