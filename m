Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269767AbUICUpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269767AbUICUpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269788AbUICUnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:43:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:16789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269767AbUICUfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:35:30 -0400
Date: Fri, 3 Sep 2004 13:33:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andre Eisenbach <int2str@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-Id: <20040903133336.6d3b86b8.akpm@osdl.org>
In-Reply-To: <7f800d9f04090310562cb7015@mail.gmail.com>
References: <20040903014811.6247d47d.akpm@osdl.org>
	<7f800d9f04090310562cb7015@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Eisenbach <int2str@gmail.com> wrote:
>
> I get the following error during compilation. .config available upon request.
> 
>    CC      drivers/input/serio/i8042.o
>  drivers/input/serio/i8042.c: In function `acpi_i8042_kbd_add':
>  drivers/input/serio/i8042.c:1133: error: `i8042_data_reg' undeclared
>  (first use in thisfunction)

Yeah.  You'll need to do:

wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/broken-out/acpi-based-i8042-keyboard-aux-controller-enumeration.patch
patch -R -p1 -i acpi-based-i8042-keyboard-aux-controller-enumeration.patch
