Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUEAAJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUEAAJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 20:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUEAAJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 20:09:27 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:39660 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261867AbUEAAJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 20:09:27 -0400
From: Lev Makhlis <mlev@despammed.com>
To: "Michael Brown" <mebrown@michaels-house.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATE 2
Date: Fri, 30 Apr 2004 19:09:49 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404302009.49576.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	for (fp = 0xF0000; fp < 0xFFFFF; fp += 16) {
> +		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
> +		if (memcmp(table_eps->anchor, "_SM_", 4)!=0)
> +			continue;

This is fine for x86 and x86_64, but for ia64 -- don't you need
to get the SMBIOS entry point from the EFI table?

