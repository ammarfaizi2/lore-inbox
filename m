Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266131AbRF2RpP>; Fri, 29 Jun 2001 13:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266132AbRF2RpG>; Fri, 29 Jun 2001 13:45:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9993 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266131AbRF2Roy>; Fri, 29 Jun 2001 13:44:54 -0400
Subject: Re: core dump problem with a multi-threaded program
To: yahui@gambitcomm.com (Yahui Lin)
Date: Fri, 29 Jun 2001 18:44:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, support@gambitcomm.com, yahui@gambitcomm.com
In-Reply-To: <3B3CBAD5.9129B6F3@gambitcomm.com> from "Yahui Lin" at Jun 29, 2001 01:28:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15G2JY-0000h9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> multi-threaded program is not possible under RedHat Linux 7.1 (kernel
> version 2.4.2-2), because loading the core into gdb 5.0 does not show
> the correct crash location.

2.4.2 doesn't support multithreaded core dumps. 
The RH errata kernel will generate a dump for each thread as/if/when that thread
crashes

You can then inspect the relevant core.pid file, I've no idea how well the
gdb thread stuff works with it.

