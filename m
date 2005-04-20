Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVDTCMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVDTCMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 22:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDTCMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 22:12:46 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:9149 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261269AbVDTCMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 22:12:44 -0400
Date: Wed, 20 Apr 2005 04:12:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ppc64: rename arch/ppc64/kernel/pSeries_pci.c
Message-ID: <20050420021245.GA7257@wohnheim.fh-wedel.de>
References: <200504200149.22063.arnd@arndb.de> <200504200152.58965.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504200152.58965.arnd@arndb.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 April 2005 01:52:56 +0200, Arnd Bergmann wrote:
>
> -	if (buid) {
> -		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
> -				addr, buid >> 32, buid & 0xffffffff, size);
> -	} else {
> -		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
> -	}
> -	*val = returnval;
> -
> -	if (ret)
> -		return PCIBIOS_DEVICE_NOT_FOUND;

You might want to be consistent wrt. braces for one-line conditional
statements.

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
