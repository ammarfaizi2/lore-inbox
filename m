Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTEOCKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTEOCKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:10:37 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:65474 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263665AbTEOCKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:10:35 -0400
Subject: 2.5.69-mm5: reverting i8259-shutdown.patch
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1052965395.758.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 15 May 2003 04:23:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Andrew,

Besides the "make_KOBJ_NAME-match_BUS_ID_SIZE.patch" causing "pccard"
oopses, I've also found that, with 2.5.69-mm5 compiled with ACPI
support, my laptop is unable to power off. The kernel invokes
"acpi_power_off" and stays there forever.

I've found that reverting the "i8259-shutdown.patch" fixes the problem
and my laptop is able to shutdown properly (init 0) when using ACPI.

A hardware bug? A kernel bug?

Thanks!


