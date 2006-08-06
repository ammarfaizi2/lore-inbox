Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWHFJfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWHFJfp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 05:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWHFJfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 05:35:45 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:33040 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751327AbWHFJfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 05:35:44 -0400
Message-ID: <44D5B78B.5040509@shadowen.org>
Date: Sun, 06 Aug 2006 10:34:03 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc3-mm1: new i2c build failure
References: <20060806002400.694948a1.akpm@osdl.org>
In-Reply-To: <20060806002400.694948a1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems we've gained an i2s (?) build failure:

   LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xe6460): In function `.ams_i2c_read':
: undefined reference to `.i2c_smbus_read_byte_data'
drivers/built-in.o(.text+0xe6540): In function `.ams_i2c_write':
: undefined reference to `.i2c_smbus_write_byte_data'
drivers/built-in.o(.text+0xe6a18): In function `.ams_i2c_exit':
: undefined reference to `.i2c_del_driver'
drivers/built-in.o(.init.text+0x8714): In function `.ams_i2c_init':
: undefined reference to `.i2c_register_driver'
make: *** [.tmp_vmlinux1] Error 1

Machine is a ppc64, config at link below:

http://test.kernel.org/abat/43793/build/dotconfig

-apw
