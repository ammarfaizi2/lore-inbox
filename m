Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSKKO06>; Mon, 11 Nov 2002 09:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265395AbSKKO06>; Mon, 11 Nov 2002 09:26:58 -0500
Received: from ma-northadams1b-126.bur.adelphia.net ([24.52.166.126]:14208
	"EHLO ma-northadams1b-126.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S265368AbSKKO05>; Mon, 11 Nov 2002 09:26:57 -0500
Date: Mon, 11 Nov 2002 14:34:41 +0000
From: Eric Buddington <eric@ma-northadams1b-126.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47: Link-time error: llc_sap_open when using modules
Message-ID: <20021111143441.A28688@ma-northadams1b-126.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a long-standing error, I think even discussed before. It goes
away if I set the LLC options to 'Y' instead of 'M'.

With most things configured as modules, make bzImage says:

net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0x12ea6): undefined reference to `llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0x12efd): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0x12f42): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0x130d2): undefined reference to `llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.init.text+0x6d3): undefined reference to `llc_sap_open'
make: *** [.tmp_vmlinux1] Error 1

-Eric
