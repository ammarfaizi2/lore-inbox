Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTKTKeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTKTKeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:34:14 -0500
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:60045 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261719AbTKTKeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:34:09 -0500
From: Frank Dekervel <kervel@drie.kotnet.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Date: Thu, 20 Nov 2003 11:34:03 +0100
User-Agent: KMail/1.5.93
Cc: linux-kernel@vger.kernel.org
References: <200311191749.28327.kervel@drie.kotnet.org> <20031119165928.70a1d077.akpm@osdl.org>
In-Reply-To: <20031119165928.70a1d077.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200311201134.04050.kervel@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

Op Thursday 20 November 2003 01:59, schreef Andrew Morton:
> > 2.6.0-test9-mm4 doesn't boot for me ... oops followed by
> > kernel panic - attempted to kill init (2.6.0-test9 works fine).
> > it crashes right after initialising PNP  bios.
>
> Please make sure that you have CONFIG_KALLSYMS set.

it is set ... but no decoded output. probably something is messed up
kervel@bakvis:~$ cat /boot/config-2.6.0-test9-mm4 | grep -i kall
CONFIG_KALLSYMS=y

>
> It would help to add `initcall_debug' to the kernel boot command line.
> That way you will find out the address of the final initcall which was
> invoked before the kernel crashed.  Please look that up in System.map.

kervel@bakvis:~$ cat /boot/System.map-2.6.0-test9-mm4 | grep c052ed91
c052ed91 T pnpbios_init

pnpbios says something like this:
 found installation structure 0xc00f5560
 version 1.0 entry 0xf0000:0x6149 dseg 0xf0000

i'm going to try without pnpbios i think.

my working 2.6.0test9 also has pnpbios setup:
kervel@bakvis:~$ cat /boot/config-2.6.0-test9 | grep -i pnpbios
CONFIG_PNPBIOS=y


greetings,
frank

-- 
Frank Dekervel - frank.dekervel@student.kuleuven.ac.be
Mechelsestraat 88
3000 Leuven (Belgium)
