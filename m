Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbTGIEsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 00:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbTGIEsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 00:48:54 -0400
Received: from mithril.c-zone.net ([63.172.74.235]:21779 "EHLO mail.c-zone.net")
	by vger.kernel.org with ESMTP id S265656AbTGIEsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 00:48:53 -0400
Message-ID: <3F0BA241.8020508@c-zone.net>
Date: Tue, 08 Jul 2003 22:04:01 -0700
From: jiho@c-zone.net
Organization: Kidding of Course
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?C=E9dric?= Barboiron <ced2ml@ifrance.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hdX lost interrupt problem
References: <3F0AE4DF.80808@ifrance.com> <3F0B6930.3080009@c-zone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jiho@c-zone.net wrote:

 > I seem to recall one incident  while I was unrolling a tarball off a
 >  CD onto a hard drive, that  happened to involve a VIA chipset.

I don't have a record of it, but as I remember, when that happened I had 
APIC enabled in the BIOS.  After that, I switched to PIC.

In this machine's BIOS Setup BIOS FEATURES SETUP screen, there's the line:

   Interrupt Mode         : PIC

The other option is APIC.  Make sure it says PIC.

I think it was Alan Cox who pointed out that on single-processor systems 
you need to have PIC, and not APIC enabled.  And my kernel wasn't even 
built with APIC support ("# CONFIG_X86_UP_APIC is not set").

APIC is a newer interrupt controller type, PIC is the orginal 8259A 
type.  These chipsets can emulate either type in hardware.

I don't know if that's your problem, but you might check.


-- Jim Howard  <jiho@c-zone>

