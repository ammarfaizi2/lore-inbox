Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbUKRLis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbUKRLis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 06:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUKRLge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 06:36:34 -0500
Received: from mail.renesas.com ([202.234.163.13]:53635 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262733AbUKRLgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 06:36:09 -0500
Date: Thu, 18 Nov 2004 20:35:56 +0900 (JST)
Message-Id: <20041118.203556.1015281353.takata.hirokazu@renesas.com>
To: rddunlap@osdl.org
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc2-bk1] media: Update drivers/media/video/arv.c
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <419B7D9B.9050302@osdl.org>
References: <20041117.153201.27776357.takata.hirokazu@renesas.com>
	<419B7D9B.9050302@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for your kind comment, Randy.

From: "Randy.Dunlap" <rddunlap@osdl.org>
Date: Wed, 17 Nov 2004 08:34:35 -0800
> > -MODULE_PARM(freq, "i");
> > -MODULE_PARM(vga, "i");
> > -MODULE_PARM(vga_interlace, "i");
> > +module_param(freq, int, 0644);
> > +module_param(vga, bool, 0644);
> > +module_param(vga_interlace, bool, 0644);
> 
> Do you want freq, vga, and vga_interface to be writeable _after_ the
> driver is loaded?  (i.e., dynamic)
> 

Yes.

I think it is preferable to make a parameter "freq" writable,
because system clock (or bus clock) might be changed dynamically
in order to reduce system power consumption, especially for embedded systems.

btw, I have no idea whether the other parameters are required to be writable
or not...

-- Takata
