Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVLUMWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVLUMWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 07:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVLUMWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 07:22:42 -0500
Received: from trinity.work.de ([212.12.32.87]:42968 "EHLO work.de")
	by vger.kernel.org with ESMTP id S932345AbVLUMWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 07:22:41 -0500
From: Nils Meyer <meyer@work.de>
To: linux-kernel@vger.kernel.org
Subject: Linking fails on sparc64 with 2.6.15-rc6 and Sun GEM Ethernet driver
Date: Wed, 21 Dec 2005 13:23:18 +0100
User-Agent: KMail/1.9
Organization: n@work GmbH
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512211323.19242.meyer@work.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When compiling 2.6.15-rc6 or 2.6.14.4 on my sparc I get the following error:

local symbol 0: discarded in section `.exit.text' from drivers/built-in.o [*]

After calling scripts/reference_discarded.pl it gives me the following error:

Error: ./drivers/net/sungem.o .init.text refers to 0000000000000448 
R_SPARC_WDISP30   .exit.text

When I disable the Sun GEM driver in the configuration it compiles cleanly 
(didn't try booting as I need the network working to connect to the server).

Let me know if you need more information. I can also provide remote access 
(ssh) to the server if needed. 

kind regards
Nils Meyer


* Last command executed by make: 
ld -m elf64_sparc  -o .tmp_vmlinux1 -T arch/sparc64/kernel/vmlinux.lds 
arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o  init/built-in.o 
--start-group  usr/built-in.o  arch/sparc64/kernel/built-in.o  
arch/sparc64/mm/built-in.o  arch/sparc64/math-emu/built-in.o  
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  
security/built-in.o  crypto/built-in.o  block/built-in.o  lib/lib.a  
arch/sparc64/prom/lib.a  arch/sparc64/lib/lib.a  lib/built-in.o  
arch/sparc64/prom/built-in.o  arch/sparc64/lib/built-in.o  drivers/built-in.o  
sound/built-in.o  net/built-in.o --end-group

-- 
n@work Internet Informationssysteme | Nils Meyer <meyer@work.de>
n@work.de - http://www.work.de      | - Technik
tel: 040/238809-0                   | 
fax: 040/238909-29                  | Spaldingstr. 160d, 20097 Hamburg 
