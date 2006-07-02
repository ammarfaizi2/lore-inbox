Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWGBQJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWGBQJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 12:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWGBQJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 12:09:58 -0400
Received: from xenotime.net ([66.160.160.81]:18056 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932514AbWGBQJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 12:09:58 -0400
Date: Sun, 2 Jul 2006 09:12:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: yh@bizmail.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6 config for module load
Message-Id: <20060702091242.f2b9fd4b.rdunlap@xenotime.net>
In-Reply-To: <44A7B3C2.5030208@bizmail.com.au>
References: <44A7B3C2.5030208@bizmail.com.au>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jul 2006 21:53:38 +1000 Jim wrote:

> Hello,
> 
> I have a device driver which can be configurated in kernel 2.4 to be a 
> loadable module. But, in kernel 2.6, I made it as tristate in Kconfig. 
> On make menuconfig list, I can only select it to [*]NewModule for kernel 
> built-in, I cannot select it to [M]NewModule for loadable module 
> (neither did I press key M or Space key produce [M]). Is it wrong to 
> specify tristate in Kconfig to make a loadable module in kernel 2.6? Or 
> what was I missing in kernel 2.6 config?

Tristate is OK.  Of course, you will also need
CONFIG_MODULES=y
to enable module support.  Is that enabled?

There are a few hundred examples of tristate loadable modules
in Kconfig files that you could look at.

---
~Randy
