Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbUDFXjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUDFXjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:39:04 -0400
Received: from main.gmane.org ([80.91.224.249]:8130 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264099AbUDFXiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:38:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: [2.4] bttv and sparc64
Date: Tue, 06 Apr 2004 16:39:44 -0700
Message-ID: <pan.2004.04.06.23.39.42.565881@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-186-145.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Many modules on sparc64 seem to require I2C support to
compile correctly. Why do they not depend on CONFIG_I2C?

The list of missing symbols is as follows --

depmod: *** Unresolved symbols in ./lib/modules/2.4.25-sparc64/kernel/drivers/media/video/bttv.o
depmod: 	i2c_bit_add_bus_R73af847e
depmod: 	i2c_bit_del_bus_R96bec566
depmod: 	i2c_master_recv_R7bd34477
depmod: 	virt_to_bus_not_defined_use_pci_map
depmod: 	i2c_master_send_Rbcec30fe
depmod: *** Unresolved symbols in ./lib/modules/2.4.25-sparc64/kernel/drivers/media/video/msp3400.o
depmod: 	i2c_detach_client_R13852119
depmod: 	i2c_attach_client_R29fbc42c
depmod: 	i2c_add_driver_R64fc78c7
depmod: 	i2c_probe_Red036271
depmod: 	i2c_transfer_Rcd9848a7
depmod: 	i2c_del_driver_Re73c7489
depmod: 	i2c_master_send_Rbcec30fe
depmod: *** Unresolved symbols in ./lib/modules/2.4.25-sparc64/kernel/drivers/media/video/tda7432.o
depmod: 	i2c_detach_client_R13852119
depmod: 	i2c_attach_client_R29fbc42c
depmod: 	i2c_add_driver_R64fc78c7
depmod: 	i2c_probe_Red036271
depmod: 	i2c_del_driver_Re73c7489
depmod: 	i2c_master_send_Rbcec30fe
depmod: *** Unresolved symbols in ./lib/modules/2.4.25-sparc64/kernel/drivers/media/video/tda9875.o
depmod: 	i2c_detach_client_R13852119
depmod: 	i2c_attach_client_R29fbc42c
depmod: 	i2c_add_driver_R64fc78c7
depmod: 	i2c_probe_Red036271
depmod: 	i2c_transfer_Rcd9848a7
depmod: 	i2c_del_driver_Re73c7489
depmod: 	i2c_master_send_Rbcec30fe
depmod: *** Unresolved symbols in ./lib/modules/2.4.25-sparc64/kernel/drivers/media/video/tda9887.o
depmod: 	i2c_detach_client_R13852119
depmod: 	i2c_attach_client_R29fbc42c
depmod: 	i2c_add_driver_R64fc78c7
depmod: 	i2c_probe_Red036271
depmod: 	i2c_del_driver_Re73c7489
depmod: 	i2c_master_send_Rbcec30fe
depmod: *** Unresolved symbols in ./lib/modules/2.4.25-sparc64/kernel/drivers/media/video/tuner.o
depmod: 	i2c_detach_client_R13852119
depmod: 	i2c_attach_client_R29fbc42c
depmod: 	i2c_master_recv_R7bd34477
depmod: 	i2c_add_driver_R64fc78c7
depmod: 	i2c_probe_Red036271
depmod: 	i2c_del_driver_Re73c7489
depmod: 	i2c_master_send_Rbcec30fe
depmod: *** Unresolved symbols in ./lib/modules/2.4.25-sparc64/kernel/drivers/media/video/tvaudio.o
depmod: 	i2c_detach_client_R13852119
depmod: 	i2c_attach_client_R29fbc42c
depmod: 	i2c_master_recv_R7bd34477
depmod: 	i2c_add_driver_R64fc78c7
depmod: 	i2c_probe_Red036271
depmod: 	i2c_transfer_Rcd9848a7
depmod: 	i2c_del_driver_Re73c7489
depmod: 	i2c_master_send_Rbcec30fe
depmod: *** Unresolved symbols in ./lib/modules/2.4.25-sparc64/kernel/drivers/usb/w9968cf.o
depmod: 	i2c_del_adapter_R63923866
depmod: 	i2c_add_adapter_R04de9506

Any idea what's up? This is 2.4.25 with Debian patches applied (they don't
affect this behavior.)

-- 
Joshua Kwan


