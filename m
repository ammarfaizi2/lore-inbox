Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266548AbSLJDR6>; Mon, 9 Dec 2002 22:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbSLJDR6>; Mon, 9 Dec 2002 22:17:58 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:6150 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S266548AbSLJDR5>;
	Mon, 9 Dec 2002 22:17:57 -0500
Date: Mon, 9 Dec 2002 19:22:43 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: capable open_port() check wrong for kmem
Message-ID: <20021210032242.GA17583@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

	I found that I can't open /dev/kmem O_RDONLY.  The open_mem
and open_kmem calls (open_port()) in drivers/char/mem.c checks for
CAP_SYS_RAWIO.

	Is there a possibility of splitting that off into a read and
write pair, i.e. CAP_SYS_RAWIO_WRITE, CAP_SYS_RAWIO_READ?

	If not, is there a way to grant read-only access to /dev/kmem?

-- DN
Daniel
