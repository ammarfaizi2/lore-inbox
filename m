Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290543AbSARAC3>; Thu, 17 Jan 2002 19:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290542AbSARACT>; Thu, 17 Jan 2002 19:02:19 -0500
Received: from jffdns01.or.intel.com ([134.134.248.3]:60120 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S290543AbSARACI>; Thu, 17 Jan 2002 19:02:08 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D853@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Dave Jones'" <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Cc: Jes Sorensen <jes@wildopensource.com>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: RE: [patch] VAIO irq assignment fix
Date: Thu, 17 Jan 2002 16:01:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@suse.de]
>  I was under the impression that the Intel ACPI folks had things in
>  mind for acpitable.c along the lines of 'rm', in favour of having 
>  their new interpretor do a "Load, setup, get the hell out" approach
>  for those that didn't want it staying around.

acpitable.c was written to support machines with a bad MPS table but a valid
$PIR. The 20011218 ACPI patch more closely integrates that code with the
rest, but the ability to get at the MADT (the ACPI MPS replacement table)
and other tables without the interpreter is still supported. The code is
under drivers/acpi, though.

I don't see that option going away any time soon.

However, without a valid $PIR (which is what is becoming more common and is
the Sony's problem) you need the interpreter, like Kai mentioned. We are
working to incorporate Kai's code into the next acpi patch, which will
evaluate and use _PRT properly. In fact, that's just what I was working on
this afternoon, so Real Soon Now. ;-)

Regards -- Andy
