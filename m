Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTILXUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbTILXUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:20:46 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:11418 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261946AbTILXT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:19:57 -0400
Subject: Re: stack overflow
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Breno <brenosp@brasilsec.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030912230601.GU4306@holomorphy.com>
References: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br>
	 <20030912165047.Z18851@schatzie.adilger.int>
	 <20030912230601.GU4306@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063408711.6740.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 00:18:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 00:06, William Lee Irwin III wrote:
> What he actually wants is in-kernel user stack overflow checking, which
> is basically impossible since user stacks are demand paged. He's been
> told this before and failed to absorb it.

We will fault and error on a user stack exceed. You need to use
sigaltstack to catch it for obvious reasons. You can also use mmap and
drop in red zones on user space stacks

