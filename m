Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270980AbTHLRSY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270987AbTHLRST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:18:19 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43926 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270980AbTHLRSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:18:18 -0400
Subject: Re: generic strncpy - off-by-one error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anthony Truong <Anthony.Truong@mascorp.com>
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1060653362.5294.58.camel@huykhoi>
References: <1060653362.5294.58.camel@huykhoi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060708460.12532.59.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Aug 2003 18:14:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-12 at 02:56, Anthony Truong wrote:
> Thanks for pointing that out to me.  However, I don't think the kernel
> strncpy implementation is exactly the same as that of Standard C lib

It is true it doesnt need to be

> implementation.  Iwas just looking at it from the kernel code context. 
> There's a point in doing it the "kernel" way, to save precious CPU
> cycles from being wasted otherwise.

CPU cycles, got lots of those 8). If its going to do anything it might
be to reference an extra cache line. For people who dont need padding
2.6 has strlcpy. Lots of drivers assume strncpy fills the entire block

