Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135848AbRAHAml>; Sun, 7 Jan 2001 19:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136039AbRAHAmV>; Sun, 7 Jan 2001 19:42:21 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:46091 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S135848AbRAHAmU>;
	Sun, 7 Jan 2001 19:42:20 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: A Guy Called Tyketto <tyketto@wizard.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: FW: compile problem in 2.4.0-ac3 
In-Reply-To: Your message of "Sun, 07 Jan 2001 15:02:40 -0800."
             <20010107150240.A7070@wizard.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 11:42:12 +1100
Message-ID: <9034.978914532@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001 15:02:40 -0800, 
A Guy Called Tyketto <tyketto@wizard.com> wrote:
>I'm still seeing 
>
>#include <linuxpi.h>
>
>        at line 25 of acpi_ksyms.c. This is also the same line, in 
>patch-2.4.0-ac2 (counted the lines of each). Neither patches compile from this.

Not happening here.  -ac2 and -ac3 have the same text.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.4.0/drivers/acpi/acpi_ksyms.c linux.ac/drivers/acpi/acpi_ksyms.c
--- linux-2.4.0/drivers/acpi/acpi_ksyms.c       Thu Jan  1 01:00:00 1970
+++ linux.ac/drivers/acpi/acpi_ksyms.c  Wed Jan  3 16:49:59 2001
@@ -0,0 +1,91 @@
+/*
+ *  ksyms.c - ACPI exported symbols
+ *
+ *  Copyright (C) 2000 Andrew Grover
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/acpi.h>	<== line 25
+#include "acpi.h"

You have corrupted your patch and/or source.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
