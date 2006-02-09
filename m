Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWBINSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWBINSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 08:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWBINSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 08:18:07 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:30896 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932486AbWBINSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 08:18:04 -0500
Date: Thu, 9 Feb 2006 06:18:02 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Jes Sorensen <jes@sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Keith Owens'" <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
Message-ID: <20060209131802.GE1593@parisc-linux.org>
References: <20060208035112.GM3524@stusta.de> <200602080552.k185q9g07813@unix-os.sc.intel.com> <20060208115946.GN3524@stusta.de> <yq0d5hym0lq.fsf@jaguar.mkp.net> <20060208213825.GQ3524@stusta.de> <yq0zml0lmmg.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0zml0lmmg.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 07:53:11AM -0500, Jes Sorensen wrote:
> There's other reasons why this is a moot exercise anyway, allyesconfig
> doesn't link on ia64 due to the size of the object exceeding the reach
> of the relative link relocs. Not much you can do about that.

That'd be a toolchain problem then ... need to insert stubs.

> - HP100 driver cannot be compiled on systems without ISA support in it's
>   current state.

I have it enabled on parisc without ISA or EISA.  More details, please.

>  config HP100
>  	tristate "HP 10/100VG PCLAN (ISA, EISA, PCI) support"
> -	depends on NET_ETHERNET && (ISA || EISA || PCI)
> +	depends on NET_ETHERNET && ISA || EISA
>  	help

Also I think this is wrong.  Doesn't the precedence make this evaluate
as (NET_ETHERNET && ISA) || EISA ?
