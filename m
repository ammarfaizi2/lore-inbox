Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEGGQ>; Fri, 5 Jan 2001 01:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130121AbRAEGF4>; Fri, 5 Jan 2001 01:05:56 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:54350 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129267AbRAEGFv>;
	Fri, 5 Jan 2001 01:05:51 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac1 
In-Reply-To: Your message of "Thu, 04 Jan 2001 21:54:29 -0800."
             <3A556195.5090902@megapathdsl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2001 17:05:44 +1100
Message-ID: <20334.978674744@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2001 21:54:29 -0800, 
Miles Lane <miles@megapathdsl.net> wrote:
>make[4]: Entering directory `/usr/src/linux/drivers/acpi'
>/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' references itself (eventually).  Stop.

In drivers/acpi/Makefile, delete the line

$(MODINCL)/%.ver: CFLAGS = -I./include $(CFLAGS)

You will be able to compile but acpi may not work with module symbol
versions, so do not select module symbol versions.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
