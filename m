Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTJTR1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTJTR1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:27:37 -0400
Received: from crisium.vnl.com ([194.46.8.33]:46863 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id S262721AbTJTR1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:27:35 -0400
Date: Mon, 20 Oct 2003 18:27:34 +0100
From: Dale Amon <amon@vnl.com>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: CMD640 problem in 2.6.0-test8
Message-ID: <20031020172733.GA17379@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing these compile errors:

	LD      .tmp_vmlinux1
	drivers/built-in.o(.init.text+0x4e6b): In function `ide_setup':
	: undefined reference to `cmd640_vlb'
	drivers/built-in.o(.init.text+0x5361): In function `probe_for_hwifs':
	: undefined reference to `ide_probe_for_cmd640x'
	make: *** [.tmp_vmlinux1] Error 1

The .config contains:

	CONFIG_BLK_DEV_CMD640=y

but ide/pci/cmd640.c doesn't seem to get compiled. I tried doing it
manually and got a screen full of errors.


