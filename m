Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751734AbVLBDMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbVLBDMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbVLBDMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:12:23 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:46214 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750827AbVLBDMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:12:22 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Coywolf Qi Hunt <coywolf@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, sam@ravnborg.org
Subject: Re: [q] make modules_install as non-root? 
In-reply-to: Your message of "Fri, 02 Dec 2005 10:23:49 +0800."
             <2cd57c900512011823v153a6763t@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Dec 2005 14:11:57 +1100
Message-ID: <6221.1133493117@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005 10:23:49 +0800, 
Coywolf Qi Hunt <coywolf@gmail.com> wrote:
>Hello people,
>
>I wrote my own installkernel so I can do `make install' as non-root
>with the help of sudo. But how can we get to do `make modules_install'
>as non-root with sudo as well?
>
>The works of modules_install seem scattered over several places.  Is
>it a nice idea to factor out an *installmodules* script for `make
>modules_install' to invoke?
>
>ps:
>Linus recommend us to build as non-root and install as root.
>I ask if we should install as non-root too.

make INSTALL_MOD_PATH=<somewhere> modules_install

Then use sudo to move from <somewhere>/lib/modules/<version> to /lib/modules/<version>.

