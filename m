Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTDTMQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTDTMQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 08:16:47 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:8335 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263566AbTDTMQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 08:16:46 -0400
Date: Sun, 20 Apr 2003 16:28:04 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo@conectiva.com.br, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.4] hpt366.c cannot be built in current 2.4 bk snapshot
Message-ID: <20030420122804.GA13559@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   hpt366.c misses PCI_DEVICE_ID_TTI_HPT372N define somewhere (probably lost
   in merge with -ac). This is starting from March 24th or thereabout.
In file included from hpt366.c:70:
hpt366.h:517: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here (not in a function)
hpt366.h:517: initializer element is not constant
hpt366.h:517: (near initialization for `hpt366_chipsets[5].device')
hpt366.h:526: initializer element is not constant
hpt366.h:526: (near initialization for `hpt366_chipsets[5].enablebits[0]')
hpt366.h:526: initializer element is not constant
hpt366.h:526: (near initialization for `hpt366_chipsets[5].enablebits[1]')
hpt366.h:526: initializer element is not constant
hpt366.h:526: (near initialization for `hpt366_chipsets[5].enablebits')
hpt366.h:529: initializer element is not constant
hpt366.h:529: (near initialization for `hpt366_chipsets[5]')
hpt366.h:534: initializer element is not constant
hpt366.h:534: (near initialization for `hpt366_chipsets[6]')
hpt366.c: In function `hpt_revision':
hpt366.c:183: `PCI_DEVICE_ID_TTI_HPT372N' undeclared (first use in this function)
hpt366.c:183: (Each undeclared identifier is reported only once
hpt366.c:183: for each function it appears in.)
hpt366.c: In function `init_setup_hpt366':
hpt366.c:1227: `PCI_DEVICE_ID_TTI_HPT372N' undeclared (first use in this function)
hpt366.c: At top level:
hpt366.c:1289: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here (not in a function)
hpt366.c:1289: initializer element is not constant
hpt366.c:1289: (near initialization for `hpt366_pci_tbl[5].device')
hpt366.c:1289: initializer element is not constant
hpt366.c:1289: (near initialization for `hpt366_pci_tbl[5]')
hpt366.c:1290: initializer element is not constant
hpt366.c:1290: (near initialization for `hpt366_pci_tbl[6]')
make[4]: *** [hpt366.o] Error 1

Bye,
    Oleg
