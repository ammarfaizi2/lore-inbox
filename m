Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVJKTVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVJKTVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVJKTVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:21:38 -0400
Received: from mail.suse.de ([195.135.220.2]:23250 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932344AbVJKTVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:21:38 -0400
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-kernel@vger.kernel.org, Georg Lippold <georg.lippold@gmx.de>
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
References: <431628D5.1040709@zytor.com> <4345A9F4.7040000@uni-bremen.de>
	<434A6220.3000608@gmx.de>
	<9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>
	<434A8082.9060202@zytor.com> <434A8CE8.2020404@gmx.de>
	<434A8D70.5060300@zytor.com>
	<20051010171605.GA7793@georg.homeunix.org>
	<434AB1EB.6070309@gmail.com> <434AD0EB.6000405@gmx.de>
	<9e0cf0bf0510110132y64c5b42dsb2211d4e75d06f15@mail.gmail.com>
	<434BED55.10603@gmx.de> <434BF9ED.9090405@gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 11 Oct 2005 21:21:34 +0200
In-Reply-To: <434BF9ED.9090405@gmail.com>
Message-ID: <p73br1vsvup.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev <alon.barlev@gmail.com> writes:
> 
> +config COMMAND_LINE_MAX_SIZE
> +	int "Maximum kernel command-line size"
> +	default 512
> +	help
> +	  This option allows you to specify maximum kernel command-line
> +	  for kernel to handle.

I think making that a config is a really bad idea. What happens
when the user specifies a very large value. Or a very small one?
There are subtle dependencies with the boot loader, so this is
mostly a lie anyways.  And it doesn't really safe enough memory to 
bother with a CONFIG.

Also the last time I tried to increase this all kind of systems
with old bootloaders exploded (e.g. lilo on systems with large EDID
information - search the archives). Have these issues been resolved now? 
If yes then I would suggest to just double the default.
If not it cannot be changed anyways.

-Andi
