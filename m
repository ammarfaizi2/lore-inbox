Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWGCHdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWGCHdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWGCHdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:33:14 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44215 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750870AbWGCHdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:33:13 -0400
Date: Mon, 3 Jul 2006 09:32:02 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Martin Peschke <mpeschke@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5
Message-ID: <20060703073202.GA9420@osiris.boeblingen.de.ibm.com>
References: <20060701033524.3c478698.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701033524.3c478698.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  LD      .tmp_vmlinux1
drivers/s390/built-in.o(.text+0x587f2): In function `zfcp_ccw_set_online':
: undefined reference to `statistic_create'
drivers/s390/built-in.o(.text+0x58838): In function `zfcp_ccw_set_online':
: undefined reference to `statistic_remove'
drivers/s390/built-in.o(.text+0x58954): In function `zfcp_ccw_set_offline':
: undefined reference to `statistic_remove'
drivers/s390/built-in.o(.text+0x603e0): In function `zfcp_erp_thread':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x60676): In function `zfcp_erp_thread':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x62000): In function `zfcp_qdio_response_handler':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x622b2): In function `zfcp_qdio_sbals_from_sg':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x6258a): In function `zfcp_qdio_sbals_from_scsicmnd':
: undefined reference to `statistic_add'
drivers/s390/built-in.o(.text+0x6280c): more undefined references to `statistic_add' follow
make: *** [.tmp_vmlinux1] Error 1

Guess there is a couple of do {} while(0) defines missing in
include/linux/statistic.h for the !CONFIG_STATISTICS case. Martin?
