Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266335AbSKLJW3>; Tue, 12 Nov 2002 04:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSKLJW3>; Tue, 12 Nov 2002 04:22:29 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:56338 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S266335AbSKLJW3>; Tue, 12 Nov 2002 04:22:29 -0500
Date: Tue, 12 Nov 2002 20:27:51 +1100
From: john slee <indigoid@higherplane.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5 bk allmodconfig compile dies at net/built-in.o
Message-ID: <20021112092750.GD17478@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, allmodconfig without software suspend, which won't compile either.
only changes are cpu => athlon/duron, and disable ata tcq.  someone
forgot to export some symbols perhaps?

net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0x12969): undefined reference to
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0x129be): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0x129ea): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0x12b37): undefined reference to
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.init.text+0x69b): undefined reference to `llc_sap_open'

j.

-- 
toyota power: http://indigoid.net/
