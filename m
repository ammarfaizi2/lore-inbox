Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUBPJ3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 04:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUBPJ3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 04:29:46 -0500
Received: from ns.suse.de ([195.135.220.2]:61339 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265452AbUBPJ3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 04:29:45 -0500
Date: Mon, 16 Feb 2004 10:27:03 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: radeon and i2c build failures
Message-ID: <20040216092703.GB23211@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


current bk.

  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xc6608): In function `radeon_probe_i2c_connector':
: undefined reference to `i2c_transfer'
drivers/built-in.o(.text+0xc682c): In function `radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xc6844): In function `radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xc685c): In function `radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xc6874): In function `radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xc695c): In function `radeon_setup_i2c_bus':
: undefined reference to `i2c_bit_add_bus'
make: *** [.tmp_vmlinux1] Error 1

this happens if i2c on ppc32 is a module.

# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_I2C=m


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
