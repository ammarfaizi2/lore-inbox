Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTCCP57>; Mon, 3 Mar 2003 10:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTCCP57>; Mon, 3 Mar 2003 10:57:59 -0500
Received: from franka.aracnet.com ([216.99.193.44]:8664 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266257AbTCCP56>; Mon, 3 Mar 2003 10:57:58 -0500
Date: Mon, 03 Mar 2003 08:08:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: Dmesg: Use a PAE enabled kernel
Message-ID: <26670000.1046707704@[10.10.2.4]>
In-Reply-To: <3E63736F.6090000@walrond.org>
References: <3E63736F.6090000@walrond.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> During bootup I see
> 
>    Warning only 4GB will be used.
>    Use a PAE enabled kernel.
> 
> But I only have 4Gb installed, so is this message wrong?

Publish the dump of the e820 map you get at the start of boot.
You'll probably find that the 4Gb of RAM is spread over a range of
physical addresses > 4Gb in size (for a start, there's a PCI window
from 3.75 to 4 Gb). If there's no other bigger holes, probably it's
faster if you just let it waste that 256Mb.

M.

