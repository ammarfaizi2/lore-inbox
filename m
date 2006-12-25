Return-Path: <linux-kernel-owner+w=401wt.eu-S1754471AbWLYMgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbWLYMgo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 07:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbWLYMgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 07:36:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59049 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbWLYMgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 07:36:43 -0500
Subject: Re: [PATCH -mm] MMCONFIG: Fix x86_64 ioremap base_address
From: Arjan van de Ven <arjan@infradead.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: OGAWA Hirofumi <hogawa@miraclelinux.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87fyb6n86a.fsf@duaron.myhome.or.jp>
References: <lrfyb7ctm8.fsf@dhcp-0242.miraclelinux.com>
	 <1166869244.3281.590.camel@laptopd505.fenrus.org>
	 <87fyb6n86a.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 25 Dec 2006 13:36:37 +0100
Message-Id: <1167050198.3281.1635.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Current workaround is the following (both of linus and -mm),
> 
> 	if (pci_mmcfg_config_num == 1 &&
> 		cfg->pci_segment_group_number == 0 &&
> 		(cfg->start_bus_number | cfg->end_bus_number) == 0)
>                 /* Assume it can access 256M range */
> 
> But, if the system has bus number 0 only, it's a correct table.
> We may need to detect the broken system. blacklist?

or just... not assume 256Mb but assume broken?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

