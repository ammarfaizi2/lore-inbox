Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWASAVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWASAVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWASAVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:21:00 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:16604 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161086AbWASAU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:20:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=E7pC2LTWegPBBXEuItALsli2AlDoocj/Zw9RRfm1EWxBHOZclsDUVamvowWcvzJuJpw5GKRaydIzlACwOfPNZXE2ARuSWcBuq7CZLOWUjfmgko9FFk6DUGCab4r9VYw5tLfZgC7IYjQ9mAYziG5niz4NgBj935UVO+RD5XOL10k=
Date: Thu, 19 Jan 2006 01:20:40 +0100
From: Diego Calleja <diegocg@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: CONFIG_ACPI_PROCESSOR=y confuses the cpu scheduler
Message-Id: <20060119012040.733335f4.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I compile CONFIG_ACPI_PROCESSOR in the kernel, one of the two cpus
doesn't get scheduled any process. The CPU works and everything, it
services interrupts and I can force processes to run on that CPU
with taskset, but they won't get scheduled in that CPU no matter
how much processes and load you put on the machine.

However, when I compile it as a module everything works fine. I can't
say when this started happening; I noticed it in the current linus 
git tree from a couple of days ago, but testing 2.6.15-rc7 didn't
help. The machine is a dual P3 machine.

Here's a working dmesg: http://terra.es/personal/diegocg/dmesg-acpi
a dmesg of the machine after setting CONFIG_ACPI_PROCESSOR to y:
http://terra.es/personal/diegocg/dmesg-acpi-no
and a acpidump output: http://terra.es/personal/diegocg/acpidump


