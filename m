Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTBPJx1>; Sun, 16 Feb 2003 04:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTBPJx1>; Sun, 16 Feb 2003 04:53:27 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:34692 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266161AbTBPJx0>; Sun, 16 Feb 2003 04:53:26 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Kunihiro Ishiguro <kunihiro@ipinfusion.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, rct@gherkin.frus.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87ptptx9z1.wl@ipinfusion.com>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>
	 <20030215135345.GA16783@merlin.emma.line.org>
	 <87ptptx9z1.wl@ipinfusion.com>
Organization: 
Message-Id: <1045389793.2068.39.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Feb 2003 10:03:13 +0000
Subject: Re: Linux v2.5.61
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-16 at 01:58, Kunihiro Ishiguro wrote:
> >Well, the kernel doesn't link for me when IPV6 is compiled as a module (config
> >below) -- linking IPv6 in is fine.
> 
> Here is a fix for xfrm6_get_type() link problem when IPv6 is
> configured as a module.

> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)

No. Do not ever use #ifdef CONFIG_xxx_MODULE. You should be able to
build modules later by adding them to your config.

-- 
dwmw2

