Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUBZSj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUBZSj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:39:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:31204 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262874AbUBZSj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:39:28 -0500
Date: Thu, 26 Feb 2004 10:45:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Deepak Saxena <dsaxena@plexity.net>
cc: greg@kroah.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Fix dev_printk to work with unclaimed devices
In-Reply-To: <20040226183439.GA17722@plexity.net>
Message-ID: <Pine.LNX.4.58.0402261044220.7830@ppc970.osdl.org>
References: <20040226183439.GA17722@plexity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Feb 2004, Deepak Saxena wrote:
> 
> I need to do some fixup in platform_notify() and when trying to 
> use the dev_* print functions for informational messages, they OOPs 
> b/c the current code assumes that dev->driver exists. This is not the 
> case since platform_notify() is called before a device has been attached
> to any driver. 

Make it a real function with varags, please.

On the other hand, it also is probably just _wrong_ to use "dev_printk()" 
if you aren't the driver for the device.

		Linus
