Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTEZW0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbTEZW0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:26:06 -0400
Received: from h-64-105-35-59.SNVACAID.covad.net ([64.105.35.59]:4484 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S262306AbTEZWKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:10:43 -0400
Date: Mon, 26 May 2003 15:23:05 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305262223.h4QMN5D12796@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-bk19 "make" messages much less informative
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	2.5.69-bk19 dumbs down the messages from make into a format
like so:

  CC      arch/i386/kernel/doublefault.o
  CC      arch/i386/kernel/acpi/boot.o
  CC      arch/i386/kernel/acpi/sleep.o
  AS      arch/i386/kernel/acpi/wakeup.o
  LD      arch/i386/kernel/acpi/built-in.o
  CC      arch/i386/kernel/cpu/common.o

	This is much less informative than seeing the actual CC commands.
It impedes people doing their own debugging and people helping others
remotely (because they want to know exactly what options were passed
to gcc).

	Also, I used to be able to copy and paste the gcc command
for compiling a particular file when I'm trying to get rid of compiler
errors.  As a result, this change slightly reduces the amount or quality
of software that I write in a given amount of time.

	Please revert it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
