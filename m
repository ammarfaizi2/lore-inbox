Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSFJEom>; Mon, 10 Jun 2002 00:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSFJEol>; Mon, 10 Jun 2002 00:44:41 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:50073 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S316629AbSFJEok>; Mon, 10 Jun 2002 00:44:40 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: miles@megapathdsl.net
Subject: Re: 2.5.20 -- mpparse.c:1123: `mp_ioapic_routing' undeclared [ ... on 2.5.21]
Date: Sun, 9 Jun 2002 00:45:22 -0400
User-Agent: KMail/1.4.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200206090045.22197.ivangurdiev@linuxfreemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.. 2.5.21 and the bug is still there....


Well, here's why it happens:
the mp_ioapic_routing structure is if-deffed for IO_APIC,
while it's extensively being used in mp_parse_prt() which is if-deffed for 
ACPI_PCI only. Therefore, it ends up being undefined when we have
checked on ACPI and LOCAL_APIC, and off IOAPIC.

How to fix it?
Umm, I do not know.
I'm a newbie...
I was hoping somebody else would fix it, but that's not happening.
The ifdef statements have to be set up correctly..


I am still curious as to why this file is even being compiled....
it seems to contain only multiprocessor stuff....
But it's compiled for everybody that says yes to LOCAL_APIC,
including non-smp boxes....






