Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317391AbSFRMSW>; Tue, 18 Jun 2002 08:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSFRMSV>; Tue, 18 Jun 2002 08:18:21 -0400
Received: from kim.it.uu.se ([130.238.12.178]:21391 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S317391AbSFRMSU>;
	Tue, 18 Jun 2002 08:18:20 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15631.9479.534511.239780@kim.it.uu.se>
Date: Tue, 18 Jun 2002 14:18:15 +0200
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5 floppy driver status [was: 2.5.22 Floppy Oops]
In-Reply-To: <20020618005007.GA2001@wizard.com>
References: <20020618005007.GA2001@wizard.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Guy Called Tyketto writes:
 >         This oops is reproducible on 2.5.22 with the floppy driver built as a
 > module. Steps involved were:

[oops from generic_unplug_device()]

Known issue.

The problem is that the floppy driver is broken since the block I/O
and VFS changes in 2.5.13. I have a partial fix, which you can get from
http://www.csd.uu.se/~mikpe/linux/patches/2.5/patch-fix-floppy-2.5.22
or from the current -dj patch kit, but it only repairs raw access so
things like tar/dd to/from /dev/fd0 work. VFS access to mounted floppies
causes data corruption, but I have no fix in sight for that yet.

/Mikael
