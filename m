Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267976AbTAMSLw>; Mon, 13 Jan 2003 13:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267967AbTAMSLw>; Mon, 13 Jan 2003 13:11:52 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:59646 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S267943AbTAMSLv>; Mon, 13 Jan 2003 13:11:51 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8E5@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>
Cc: "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Cleverdon'" <jamesclv@us.ibm.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Date: Mon, 13 Jan 2003 12:19:55 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

I ran into a couple places where CONFIG_X86_NUMA is still there (replaced
now with CONFIG_X86_NUMAQ), which disables following defines:

in asm-i386/apicdef.h:

...
#ifdef CONFIG_X86_NUMA
 #define MAX_IO_APICS 32
...


and in asm-i386/mpspec.h:
...
/*
 * a maximum of 16 APICs with the current APIC ID architecture.
 */
#ifdef CONFIG_X86_NUMA
#define MAX_APICS 256
#else /* !CONFIG_X86_NUMA */
#define MAX_APICS 16
#endif /* CONFIG_X86_NUMA */
...


--Natalie
