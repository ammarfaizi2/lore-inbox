Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVAERcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVAERcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVAER3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:29:46 -0500
Received: from mail.gmx.de ([213.165.64.20]:31897 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262515AbVAER3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:29:05 -0500
X-Authenticated: #1425685
Date: Wed, 5 Jan 2005 18:28:20 +0100
From: Sebastian <Ostdeutschland@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: /proc/acpi/debug_level broken ?
Message-Id: <20050105182820.3e28bb86.Ostdeutschland@gmx.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when trying 'cat /proc/acpi/debug_level' i get the following:

admin@workstation:~$ cat /proc/acpi/debug_level 
Description                     Hex        SET
ACPI_LV_ERROR                   0x00000001 [*]
ACPI_LV_WARN                    0x00000002 [*]
ACPI_LV_INIT                    0x00000004 [*]
ACPI_LV_DEBUG_OBJECT            0x00000008 [*]
ACPI_LV_INFO                    0x00000010 [ ]
ACPI_LV_INIT_NAMES              0x00000020 [ ]
ACPI_LV_PARSE                   0x00000040 [ ]
ACPI_LV_LOAD                    0x00000080 [ ]
ACPI_LV_DISPATCH                0x00000100 [ ]
ACPI_LV_EXEC                    0x00000200 [ ]
ACPI_LV_NAMES                   0x00000400 [ ]
ACPI_LV_OPREGION                0x00000800 [ ]
ACPI_LV_BFIELD                  0x00001000 [ ]
ACPI_LV_TABLES                  0x00002000 [ ]
ACPI_LV_VALUES                  0x00004000 [ ]
ACPI_LV_OBJECTS                 0x00008000 [ ]
ACPI_LV_RESOURCES               0x00010000 [ ]
ACPI_LV_USER_REQUESTS           0x00020000 [ ]
ACPI_LV_PACKAGE                 0x00040000 [ ]
ACPI_LV_ALLOCATIONS             0x00100000 [ ]
ACPI_LV_FUNCTIONS               0x00200000 [ ]
ACPI_LV_OPTIMIZATIONS           0x00400000 [ ]
ACPI_LV_MUTEX                   0x01000000 [ ]
ACPI_LV_THREADS                 0x02000000 [ ]admin@workstation:~

Note the shell prompt directly after [ ].

Looking at driver/acpi/debug.c:129 there should be 6 more entries in
that file.

Also driver/acpi/debug.c:136,137 does not get printed.
(debug_level = 0xFFFFFFFF (* = enabled, - = partial))

Kernel version is 2.6.10. I can verify this with 2.6.9, too.

Yours,

sebastian
