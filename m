Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbSLIRCc>; Mon, 9 Dec 2002 12:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbSLIRCc>; Mon, 9 Dec 2002 12:02:32 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:17057 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265816AbSLIRCb> convert rfc822-to-8bit; Mon, 9 Dec 2002 12:02:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: build failure in 2.4.20
Date: Mon, 9 Dec 2002 18:09:57 +0100
User-Agent: KMail/1.4.3
References: <15860.46389.654483.692231@ronispc.chem.mcgill.ca>
In-Reply-To: <15860.46389.654483.692231@ronispc.chem.mcgill.ca>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: ronis@onsager.chem.mcgill.ca, David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212091809.57622.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 December 2002 16:22, David Ronis wrote:

Hi David,

> drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in
> discarded section .text.exit' make: *** [vmlinux] Error 1
> It sounds like this is a problem with ld or as, but I'm not sure.  Any
> suggestions?
$editor arch/i386/vmlinux.lds

you'll see starting at line 67 this:

  /* Sections to be discarded */
  /DISCARD/ : {
        *(.text.exit)
        *(.data.exit)
        *(.exitcall.exit)
        }

remove this:

        *(.text.exit)

try again.

ciao, Marc
