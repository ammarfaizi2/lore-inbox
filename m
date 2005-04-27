Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVD0Wa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVD0Wa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVD0W2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:28:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:40337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262054AbVD0W1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:27:12 -0400
Date: Wed, 27 Apr 2005 15:27:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-Id: <20050427152704.632a9317.rddunlap@osdl.org>
In-Reply-To: <20050427140342.GG10685@puettmann.net>
References: <20050427140342.GG10685@puettmann.net>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005 16:03:42 +0200
Ruben Puettmann <ruben@puettmann.net> wrote:

>                 hy,
> I'm trying to install linux on an HP DL385 but directly on boot I got
> this kernel panic:
> 
>         http://www.puettmann.net/temp/panic.jpg
> 
> Config attached.

Looks like this code in init/main.c:

	if (late_time_init)
		late_time_init();

sees a garbage value in late_time_init (garbage being
%eax == 0x00307974.743d656c, which is "le=tty0\n",
as in "console=tty0").

How long is your kernel boot/command line?
Please post it.

---
~Randy
