Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263217AbVCDXnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbVCDXnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbVCDXiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:38:01 -0500
Received: from waste.org ([216.27.176.166]:4776 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263221AbVCDV1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:27:46 -0500
Date: Fri, 4 Mar 2005 13:27:30 -0800
From: Matt Mackall <mpm@selenic.com>
To: Richard Fuchs <richard.fuchs@inode.info>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
Message-ID: <20050304212730.GZ3120@waste.org>
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <20050304201153.GR3163@waste.org> <4228D0D9.9010301@inode.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228D0D9.9010301@inode.info>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:19:21PM +0100, Richard Fuchs wrote:
> _correction_ to my previous mail, this does _not_ happen with the 
> eepro100 driver. (sorry for the confusion, i got the kernel images mixed 
> up with all the testing i've been doing.)
> 
> could this affect the e1000 driver as well?

Yes. 

> >Send the output of ethtool, please.

Doh. 'ethtool -k' is what's needed, sorry.

If it's reproduceable, try turning off rx/tx hardware checksumming:

ethtool -k eth0 rx off tx off

-- 
Mathematics is the supreme nostalgia of our time.
