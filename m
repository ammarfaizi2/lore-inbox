Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbUK0CeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbUK0CeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbUK0CGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:06:14 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17604 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262404AbUKZTgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:36:18 -0500
Date: Thu, 25 Nov 2004 12:18:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
In-Reply-To: <1101356864.4007.35.camel@mulgrave>
Message-ID: <Pine.LNX.4.61.0411251217090.1284@scrub.home>
References: <1101314988.1714.194.camel@mulgrave>  <1101323621.2811.24.camel@laptop.fenrus.org>
 <1101356864.4007.35.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Nov 2004, James Bottomley wrote:

> +config X86_HZ
> +       int "Clock Tick Rate"
> +       default 1000 if !(M386 || M486 || M586 || M586TSC || M586MMX)	
> +       default 100 if (M386 || M486 || M586 || M586TSC || M586MMX)	

You don't have to duplicate the conditions, kconfig takes the first match.

bye, Roman
