Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTASBfM>; Sat, 18 Jan 2003 20:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTASBfM>; Sat, 18 Jan 2003 20:35:12 -0500
Received: from holomorphy.com ([66.224.33.161]:8325 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265277AbTASBe4>;
	Sat, 18 Jan 2003 20:34:56 -0500
Date: Sat, 18 Jan 2003 17:43:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: zwane@linuxpower.ca, zab@zabbo.net, manfred@colorfullife.com,
       macro@ds2.pg.gda.pl, Martin.Bligh@us.ibm.com, jamesclv@us.ibm.com
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030119014326.GB789@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, zwane@linuxpower.ca, zab@zabbo.net,
	manfred@colorfullife.com, macro@ds2.pg.gda.pl,
	Martin.Bligh@us.ibm.com, jamesclv@us.ibm.com
References: <20030115105802.GQ940@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115105802.GQ940@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 02:58:02AM -0800, William Lee Irwin III wrote:
> (1) I've got 320 IRQ sources. This panic()'s in setup_IO_APIC_irqs().

Where do you go for IO-APIC issues? Well, my MP tables say (Zwane
pointed out fsmp@FreeBSD.org's mptable code):

===============================================================================

MPTable, version 2.0.15 Linux

-------------------------------------------------------------------------------

MP Floating Pointer Structure:

  location:			BIOS
  physical address:		0x000f6040
  signature:			'_MP_'
  length:			16 bytes
  version:			1.4
  checksum:			0x30
  mode:				Virtual Wire

-------------------------------------------------------------------------------

MP Config Table Header:

  physical address:		0x0x700000
  signature:			'PCMP'
  base table length:		3612
  version:			1.4
  checksum:			0xee
  OEM ID:			'IBM NUMA'
  Product ID:			'SBB         '
  OEM table pointer:		0x007012ec
  OEM table size:		624
  entry count:			398
  local APIC address:		0xfec08000
  extended table length:	1232
  extended table checksum:	90

-------------------------------------------------------------------------------

MP Config Base Table Entries:

--
Processors:	APIC ID	Version	State		Family	Model	Step	Flags
		 0	 0x11	 BSP, usable	 6	 10	 4	 0x387fbff
		 4	 0x11	 AP, usable	 6	 10	 4	 0x387fbff
		 1	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 2	 0x11	 AP, usable	 6	 10	 4	 0x387fbff
		 0	 0x11	 AP, usable	 6	 10	 1	 0x387fbff
		 4	 0x11	 AP, usable	 6	 10	 1	 0x387fbff
		 1	 0x11	 AP, usable	 6	 10	 1	 0x387fbff
		 2	 0x11	 AP, usable	 6	 10	 1	 0x387fbff
		 0	 0x11	 AP, usable	 6	 10	 4	 0x387fbff
		 4	 0x11	 AP, usable	 6	 10	 4	 0x387fbff
		 1	 0x11	 AP, usable	 6	 10	 4	 0x387fbff
		 2	 0x11	 AP, usable	 6	 10	 4	 0x387fbff
		 0	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 4	 0x11	 AP, usable	 6	 10	 4	 0x387fbff
		 1	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 2	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 0	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 4	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 1	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 2	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 0	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 4	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 1	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 2	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 0	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 4	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 1	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 2	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 0	 0x11	 AP, usable	 6	 10	 1	 0x387fbff
		 4	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 1	 0x11	 AP, usable	 6	 10	 0	 0x387fbff
		 2	 0x11	 AP, usable	 6	 10	 1	 0x387fbff
--
Bus:		Bus ID	Type
		 0	 PCI   
		 1	 PCI   
		 2	 PCI   
		20	 EISA  
		 3	 PCI   
		 4	 PCI   
		21	 EISA  
		 5	 PCI   
		 6	 PCI   
		 7	 PCI   
		22	 EISA  
		 8	 PCI   
		 9	 PCI   
		10	 PCI   
		23	 EISA  
		11	 PCI   
		12	 PCI   
		13	 PCI   
		24	 EISA  
		14	 PCI   
		15	 PCI   
		25	 EISA  
		16	 PCI   
		17	 PCI   
		26	 EISA  
		18	 PCI   
		19	 PCI   
		27	 EISA  
--
I/O APICs:	APIC ID	Version	State		Address
		13	 0x11	 usable		 0xfe800000
		14	 0x11	 usable		 0xfe801000
		15	 0x11	 usable		 0xfe840000
		16	 0x11	 usable		 0xfe841000
		17	 0x11	 usable		 0xfe880000
		18	 0x11	 usable		 0xfe881000
		19	 0x11	 usable		 0xfe8c0000
		20	 0x11	 usable		 0xfe8c1000
		21	 0x11	 usable		 0xfe900000
		22	 0x11	 usable		 0xfe901000
		23	 0x11	 usable		 0xfe940000
		24	 0x11	 usable		 0xfe941000
		25	 0x11	 usable		 0xfe980000
		26	 0x11	 usable		 0xfe981000
		27	 0x11	 usable		 0xfe9c0000
		28	 0x11	 usable		 0xfe9c1000
--
I/O Ints:	Type	Polarity    Trigger	Bus ID	 IRQ	APIC ID	PIN#
		ExtINT	active-hi        edge	    20	   0	     13	   0
		INT	active-hi        edge	    20	   1	     13	   1
		INT	active-hi        edge	    20	   0	     13	   2
		INT	active-hi        edge	    20	   3	     13	   3
		INT	active-hi        edge	    20	   4	     13	   4
		INT	active-hi        edge	    20	   5	     13	   5
		INT	active-hi        edge	    20	   6	     13	   6
		INT	active-lo       level	     0	  51	     13	   7
		INT	active-hi       level	    20	   8	     13	   8
		INT	active-hi        edge	    20	   9	     13	   9
		INT	active-hi        edge	    20	  10	     13	  10
		INT	active-lo       level	     0	  50	     13	  11
		INT	active-hi        edge	    20	  12	     13	  12
		INT	active-lo       level	     0	  49	     13	  13
		INT	active-hi        edge	    20	  14	     13	  14
		INT	active-lo       level	     0	  48	     13	  15
		INT	active-lo       level	     0	  47	     13	  16
		INT	active-lo       level	     0	  46	     13	  17
		INT	active-lo       level	     0	  45	     13	  18
		INT	active-lo       level	     0	  44	     13	  19
		INT	active-lo       level	     0	  43	     13	  20
		INT	active-lo       level	     0	  42	     13	  21
		INT	active-lo       level	     0	  41	     13	  22
		INT	active-lo       level	     0	  40	     13	  23
		INT	active-lo       level	     2	  63	     14	   1
		INT	active-lo       level	     2	  62	     14	   2
		INT	active-lo       level	     2	  61	     14	   3
		INT	active-lo       level	     2	  60	     14	   4
		INT	active-lo       level	     2	  59	     14	   5
		INT	active-lo       level	     2	  58	     14	   6
		INT	active-lo       level	     2	  57	     14	   7
		INT	active-lo       level	     2	  55	     14	   9
		INT	active-lo       level	     2	  54	     14	  10
		INT	active-lo       level	     2	  53	     14	  11
		INT	active-lo       level	     2	  52	     14	  12
		INT	active-lo       level	     2	  51	     14	  13
		INT	active-lo       level	     2	  50	     14	  14
		INT	active-lo       level	     2	  49	     14	  15
		INT	active-lo       level	     2	  48	     14	  16
		INT	active-lo       level	     2	  56	     14	  17
		ExtINT	active-hi        edge	    21	   0	     15	   0
		INT	active-hi        edge	    21	   1	     15	   1
		INT	active-hi        edge	    21	   0	     15	   2
		INT	active-hi        edge	    21	   3	     15	   3
		INT	active-hi        edge	    21	   4	     15	   4
		INT	active-hi        edge	    21	   5	     15	   5
		INT	active-hi        edge	    21	   6	     15	   6
		INT	active-lo       level	     3	  51	     15	   7
		INT	active-hi       level	    21	   8	     15	   8
		INT	active-hi        edge	    21	   9	     15	   9
		INT	active-hi        edge	    21	  10	     15	  10
		INT	active-lo       level	     3	  50	     15	  11
		INT	active-hi        edge	    21	  12	     15	  12
		INT	active-lo       level	     3	  49	     15	  13
		INT	active-hi        edge	    21	  14	     15	  14
		INT	active-lo       level	     3	  48	     15	  15
		INT	active-lo       level	     3	  47	     15	  16
		INT	active-lo       level	     3	  46	     15	  17
		INT	active-lo       level	     3	  45	     15	  18
		INT	active-lo       level	     3	  44	     15	  19
		INT	active-lo       level	     3	  43	     15	  20
		INT	active-lo       level	     3	  42	     15	  21
		INT	active-lo       level	     3	  41	     15	  22
		INT	active-lo       level	     3	  40	     15	  23
		INT	active-lo       level	     4	  63	     16	   1
		INT	active-lo       level	     4	  62	     16	   2
		INT	active-lo       level	     4	  61	     16	   3
		INT	active-lo       level	     4	  60	     16	   4
		INT	active-lo       level	     4	  59	     16	   5
		INT	active-lo       level	     4	  58	     16	   6
		INT	active-lo       level	     4	  57	     16	   7
		INT	active-lo       level	     4	  55	     16	   9
		INT	active-lo       level	     4	  54	     16	  10
		INT	active-lo       level	     4	  53	     16	  11
		INT	active-lo       level	     4	  52	     16	  12
		INT	active-lo       level	     4	  51	     16	  13
		INT	active-lo       level	     4	  50	     16	  14
		INT	active-lo       level	     4	  49	     16	  15
		INT	active-lo       level	     4	  48	     16	  16
		INT	active-lo       level	     4	  56	     16	  17
		ExtINT	active-hi        edge	    22	   0	     17	   0
		INT	active-hi        edge	    22	   1	     17	   1
		INT	active-hi        edge	    22	   0	     17	   2
		INT	active-hi        edge	    22	   3	     17	   3
		INT	active-hi        edge	    22	   4	     17	   4
		INT	active-hi        edge	    22	   5	     17	   5
		INT	active-hi        edge	    22	   6	     17	   6
		INT	active-lo       level	     5	12:D	     17	   7
		INT	active-hi       level	    22	   8	     17	   8
		INT	active-hi        edge	    22	   9	     17	   9
		INT	active-hi        edge	    22	  10	     17	  10
		INT	active-lo       level	     5	12:C	     17	  11
		INT	active-hi        edge	    22	  12	     17	  12
		INT	active-lo       level	     5	12:B	     17	  13
		INT	active-hi        edge	    22	  14	     17	  14
		INT	active-lo       level	     5	12:A	     17	  15
		INT	active-lo       level	     5	11:D	     17	  16
		INT	active-lo       level	     5	11:C	     17	  17
		INT	active-lo       level	     5	11:B	     17	  18
		INT	active-lo       level	     5	11:A	     17	  19
		INT	active-lo       level	     5	10:D	     17	  20
		INT	active-lo       level	     5	10:C	     17	  21
		INT	active-lo       level	     5	10:B	     17	  22
		INT	active-lo       level	     5	10:A	     17	  23
		INT	active-lo       level	     7	15:D	     18	   1
		INT	active-lo       level	     7	15:C	     18	   2
		INT	active-lo       level	     7	15:B	     18	   3
		INT	active-lo       level	     7	15:A	     18	   4
		INT	active-lo       level	     7	14:D	     18	   5
		INT	active-lo       level	     7	14:C	     18	   6
		INT	active-lo       level	     7	14:B	     18	   7
		INT	active-lo       level	     7	13:D	     18	   9
		INT	active-lo       level	     7	13:C	     18	  10
		INT	active-lo       level	     7	13:B	     18	  11
		INT	active-lo       level	     7	13:A	     18	  12
		INT	active-lo       level	     7	12:D	     18	  13
		INT	active-lo       level	     7	12:C	     18	  14
		INT	active-lo       level	     7	12:B	     18	  15
		INT	active-lo       level	     7	12:A	     18	  16
		INT	active-lo       level	     7	14:A	     18	  17
		ExtINT	active-hi        edge	    23	   0	     19	   0
		INT	active-hi        edge	    23	   1	     19	   1
		INT	active-hi        edge	    23	   0	     19	   2
		INT	active-hi        edge	    23	   3	     19	   3
		INT	active-hi        edge	    23	   4	     19	   4
		INT	active-hi        edge	    23	   5	     19	   5
		INT	active-hi        edge	    23	   6	     19	   6
		INT	active-lo       level	     8	12:D	     19	   7
		INT	active-hi       level	    23	   8	     19	   8
		INT	active-hi        edge	    23	   9	     19	   9
		INT	active-hi        edge	    23	  10	     19	  10
		INT	active-lo       level	     8	12:C	     19	  11
		INT	active-hi        edge	    23	  12	     19	  12
		INT	active-lo       level	     8	12:B	     19	  13
		INT	active-hi        edge	    23	  14	     19	  14
		INT	active-lo       level	     8	12:A	     19	  15
		INT	active-lo       level	     8	11:D	     19	  16
		INT	active-lo       level	     8	11:C	     19	  17
		INT	active-lo       level	     8	11:B	     19	  18
		INT	active-lo       level	     8	11:A	     19	  19
		INT	active-lo       level	     8	10:D	     19	  20
		INT	active-lo       level	     8	10:C	     19	  21
		INT	active-lo       level	     8	10:B	     19	  22
		INT	active-lo       level	     8	10:A	     19	  23
		INT	active-lo       level	    10	15:D	     20	   1
		INT	active-lo       level	    10	15:C	     20	   2
		INT	active-lo       level	    10	15:B	     20	   3
		INT	active-lo       level	    10	15:A	     20	   4
		INT	active-lo       level	    10	14:D	     20	   5
		INT	active-lo       level	    10	14:C	     20	   6
		INT	active-lo       level	    10	14:B	     20	   7
		INT	active-lo       level	    10	13:D	     20	   9
		INT	active-lo       level	    10	13:C	     20	  10
		INT	active-lo       level	    10	13:B	     20	  11
		INT	active-lo       level	    10	13:A	     20	  12
		INT	active-lo       level	    10	12:D	     20	  13
		INT	active-lo       level	    10	12:C	     20	  14
		INT	active-lo       level	    10	12:B	     20	  15
		INT	active-lo       level	    10	12:A	     20	  16
		INT	active-lo       level	    10	14:A	     20	  17
		ExtINT	active-hi        edge	    24	   0	     21	   0
		INT	active-hi        edge	    24	   1	     21	   1
		INT	active-hi        edge	    24	   0	     21	   2
		INT	active-hi        edge	    24	   3	     21	   3
		INT	active-hi        edge	    24	   4	     21	   4
		INT	active-hi        edge	    24	   5	     21	   5
		INT	active-hi        edge	    24	   6	     21	   6
		INT	active-lo       level	    11	12:D	     21	   7
		INT	active-hi       level	    24	   8	     21	   8
		INT	active-hi        edge	    24	   9	     21	   9
		INT	active-hi        edge	    24	  10	     21	  10
		INT	active-lo       level	    11	12:C	     21	  11
		INT	active-hi        edge	    24	  12	     21	  12
		INT	active-lo       level	    11	12:B	     21	  13
		INT	active-hi        edge	    24	  14	     21	  14
		INT	active-lo       level	    11	12:A	     21	  15
		INT	active-lo       level	    11	11:D	     21	  16
		INT	active-lo       level	    11	11:C	     21	  17
		INT	active-lo       level	    11	11:B	     21	  18
		INT	active-lo       level	    11	11:A	     21	  19
		INT	active-lo       level	    11	10:D	     21	  20
		INT	active-lo       level	    11	10:C	     21	  21
		INT	active-lo       level	    11	10:B	     21	  22
		INT	active-lo       level	    11	10:A	     21	  23
		INT	active-lo       level	    13	15:D	     22	   1
		INT	active-lo       level	    13	15:C	     22	   2
		INT	active-lo       level	    13	15:B	     22	   3
		INT	active-lo       level	    13	15:A	     22	   4
		INT	active-lo       level	    13	14:D	     22	   5
		INT	active-lo       level	    13	14:C	     22	   6
		INT	active-lo       level	    13	14:B	     22	   7
		INT	active-lo       level	    13	13:D	     22	   9
		INT	active-lo       level	    13	13:C	     22	  10
		INT	active-lo       level	    13	13:B	     22	  11
		INT	active-lo       level	    13	13:A	     22	  12
		INT	active-lo       level	    13	12:D	     22	  13
		INT	active-lo       level	    13	12:C	     22	  14
		INT	active-lo       level	    13	12:B	     22	  15
		INT	active-lo       level	    13	12:A	     22	  16
		INT	active-lo       level	    13	14:A	     22	  17
		ExtINT	active-hi        edge	    25	   0	     23	   0
		INT	active-hi        edge	    25	   1	     23	   1
		INT	active-hi        edge	    25	   0	     23	   2
		INT	active-hi        edge	    25	   3	     23	   3
		INT	active-hi        edge	    25	   4	     23	   4
		INT	active-hi        edge	    25	   5	     23	   5
		INT	active-hi        edge	    25	   6	     23	   6
		INT	active-lo       level	    14	12:D	     23	   7
		INT	active-hi       level	    25	   8	     23	   8
		INT	active-hi        edge	    25	   9	     23	   9
		INT	active-hi        edge	    25	  10	     23	  10
		INT	active-lo       level	    14	12:C	     23	  11
		INT	active-hi        edge	    25	  12	     23	  12
		INT	active-lo       level	    14	12:B	     23	  13
		INT	active-hi        edge	    25	  14	     23	  14
		INT	active-lo       level	    14	12:A	     23	  15
		INT	active-lo       level	    14	11:D	     23	  16
		INT	active-lo       level	    14	11:C	     23	  17
		INT	active-lo       level	    14	11:B	     23	  18
		INT	active-lo       level	    14	11:A	     23	  19
		INT	active-lo       level	    14	10:D	     23	  20
		INT	active-lo       level	    14	10:C	     23	  21
		INT	active-lo       level	    14	10:B	     23	  22
		INT	active-lo       level	    14	10:A	     23	  23
		INT	active-lo       level	    15	15:D	     24	   1
		INT	active-lo       level	    15	15:C	     24	   2
		INT	active-lo       level	    15	15:B	     24	   3
		INT	active-lo       level	    15	15:A	     24	   4
		INT	active-lo       level	    15	14:D	     24	   5
		INT	active-lo       level	    15	14:C	     24	   6
		INT	active-lo       level	    15	14:B	     24	   7
		INT	active-lo       level	    15	13:D	     24	   9
		INT	active-lo       level	    15	13:C	     24	  10
		INT	active-lo       level	    15	13:B	     24	  11
		INT	active-lo       level	    15	13:A	     24	  12
		INT	active-lo       level	    15	12:D	     24	  13
		INT	active-lo       level	    15	12:C	     24	  14
		INT	active-lo       level	    15	12:B	     24	  15
		INT	active-lo       level	    15	12:A	     24	  16
		INT	active-lo       level	    15	14:A	     24	  17
		ExtINT	active-hi        edge	    26	   0	     25	   0
		INT	active-hi        edge	    26	   1	     25	   1
		INT	active-hi        edge	    26	   0	     25	   2
		INT	active-hi        edge	    26	   3	     25	   3
		INT	active-hi        edge	    26	   4	     25	   4
		INT	active-hi        edge	    26	   5	     25	   5
		INT	active-hi        edge	    26	   6	     25	   6
		INT	active-lo       level	    16	12:D	     25	   7
		INT	active-hi       level	    26	   8	     25	   8
		INT	active-hi        edge	    26	   9	     25	   9
		INT	active-hi        edge	    26	  10	     25	  10
		INT	active-lo       level	    16	12:C	     25	  11
		INT	active-hi        edge	    26	  12	     25	  12
		INT	active-lo       level	    16	12:B	     25	  13
		INT	active-hi        edge	    26	  14	     25	  14
		INT	active-lo       level	    16	12:A	     25	  15
		INT	active-lo       level	    16	11:D	     25	  16
		INT	active-lo       level	    16	11:C	     25	  17
		INT	active-lo       level	    16	11:B	     25	  18
		INT	active-lo       level	    16	11:A	     25	  19
		INT	active-lo       level	    16	10:D	     25	  20
		INT	active-lo       level	    16	10:C	     25	  21
		INT	active-lo       level	    16	10:B	     25	  22
		INT	active-lo       level	    16	10:A	     25	  23
		INT	active-lo       level	    17	  63	     26	   1
		INT	active-lo       level	    17	  62	     26	   2
		INT	active-lo       level	    17	  61	     26	   3
		INT	active-lo       level	    17	  60	     26	   4
		INT	active-lo       level	    17	  59	     26	   5
		INT	active-lo       level	    17	  58	     26	   6
		INT	active-lo       level	    17	  57	     26	   7
		INT	active-lo       level	    17	  55	     26	   9
		INT	active-lo       level	    17	  54	     26	  10
		INT	active-lo       level	    17	  53	     26	  11
		INT	active-lo       level	    17	  52	     26	  12
		INT	active-lo       level	    17	  51	     26	  13
		INT	active-lo       level	    17	  50	     26	  14
		INT	active-lo       level	    17	  49	     26	  15
		INT	active-lo       level	    17	  48	     26	  16
		INT	active-lo       level	    17	  56	     26	  17
		ExtINT	active-hi        edge	    27	   0	     27	   0
		INT	active-hi        edge	    27	   1	     27	   1
		INT	active-hi        edge	    27	   0	     27	   2
		INT	active-hi        edge	    27	   3	     27	   3
		INT	active-hi        edge	    27	   4	     27	   4
		INT	active-hi        edge	    27	   5	     27	   5
		INT	active-hi        edge	    27	   6	     27	   6
		INT	active-lo       level	    18	12:D	     27	   7
		INT	active-hi       level	    27	   8	     27	   8
		INT	active-hi        edge	    27	   9	     27	   9
		INT	active-hi        edge	    27	  10	     27	  10
		INT	active-lo       level	    18	12:C	     27	  11
		INT	active-hi        edge	    27	  12	     27	  12
		INT	active-lo       level	    18	12:B	     27	  13
		INT	active-hi        edge	    27	  14	     27	  14
		INT	active-lo       level	    18	12:A	     27	  15
		INT	active-lo       level	    18	11:D	     27	  16
		INT	active-lo       level	    18	11:C	     27	  17
		INT	active-lo       level	    18	11:B	     27	  18
		INT	active-lo       level	    18	11:A	     27	  19
		INT	active-lo       level	    18	10:D	     27	  20
		INT	active-lo       level	    18	10:C	     27	  21
		INT	active-lo       level	    18	10:B	     27	  22
		INT	active-lo       level	    18	10:A	     27	  23
		INT	active-lo       level	    19	15:D	     28	   1
		INT	active-lo       level	    19	15:C	     28	   2
		INT	active-lo       level	    19	15:B	     28	   3
		INT	active-lo       level	    19	15:A	     28	   4
		INT	active-lo       level	    19	14:D	     28	   5
		INT	active-lo       level	    19	14:C	     28	   6
		INT	active-lo       level	    19	14:B	     28	   7
		INT	active-lo       level	    19	13:D	     28	   9
		INT	active-lo       level	    19	13:C	     28	  10
		INT	active-lo       level	    19	13:B	     28	  11
		INT	active-lo       level	    19	13:A	     28	  12
		INT	active-lo       level	    19	12:D	     28	  13
		INT	active-lo       level	    19	12:C	     28	  14
		INT	active-lo       level	    19	12:B	     28	  15
		INT	active-lo       level	    19	12:A	     28	  16
		INT	active-lo       level	    19	14:A	     28	  17
--
Local Ints:	Type	Polarity    Trigger	Bus ID	 IRQ	APIC ID	PIN#
		ExtINT	active-hi        edge	    18	 0:A	    255	   0
		NMI	active-hi        edge	     0	   0	    255	   1

-------------------------------------------------------------------------------

MP Config Extended Table Entries:

--
System Address Space
 bus ID: 0 address type: memory address
 address base: 0xa0000
 address range: 0x20000
--
System Address Space
 bus ID: 0 address type: memory address
 address base: 0xd0000
 address range: 0x4000
--
System Address Space
 bus ID: 0 address type: memory address
 address base: 0xfc000000
 address range: 0x1300000
--
System Address Space
 bus ID: 2 address type: memory address
 address base: 0xfd300000
 address range: 0x100000
--
System Address Space
 bus ID: 0 address type: I/O address
 address base: 0xd000
 address range: 0x2000
--
System Address Space
 bus ID: 2 address type: I/O address
 address base: 0xf000
 address range: 0x1000
--
System Address Space
 bus ID: 0 address type: I/O address
 address base: 0x0
 address range: 0xd000
--
System Address Space
 bus ID: 3 address type: memory address
 address base: 0xd0000
 address range: 0x4000
--
System Address Space
 bus ID: 3 address type: memory address
 address base: 0xf8000000
 address range: 0x2100000
--
System Address Space
 bus ID: 4 address type: memory address
 address base: 0xfa100000
 address range: 0x100000
--
System Address Space
 bus ID: 3 address type: I/O address
 address base: 0xe000
 address range: 0x1000
--
System Address Space
 bus ID: 4 address type: I/O address
 address base: 0xf000
 address range: 0x1000
--
System Address Space
 bus ID: 3 address type: I/O address
 address base: 0x0
 address range: 0xe000
--
System Address Space
 bus ID: 5 address type: memory address
 address base: 0xd0000
 address range: 0x4000
--
System Address Space
 bus ID: 5 address type: memory address
 address base: 0xe4000000
 address range: 0x2300000
--
System Address Space
 bus ID: 7 address type: memory address
 address base: 0xe6300000
 address range: 0x0
--
System Address Space
 bus ID: 5 address type: I/O address
 address base: 0xe000
 address range: 0x2000
--
System Address Space
 bus ID: 5 address type: I/O address
 address base: 0x0
 address range: 0xe000
--
System Address Space
 bus ID: 8 address type: memory address
 address base: 0xd0000
 address range: 0x4000
--
System Address Space
 bus ID: 8 address type: memory address
 address base: 0xf0000000
 address range: 0x4300000
--
System Address Space
 bus ID: 10 address type: memory address
 address base: 0xf4300000
 address range: 0x0
--
System Address Space
 bus ID: 8 address type: I/O address
 address base: 0xe000
 address range: 0x2000
--
System Address Space
 bus ID: 8 address type: I/O address
 address base: 0x0
 address range: 0xe000
--
System Address Space
 bus ID: 11 address type: memory address
 address base: 0xd0000
 address range: 0x4000
--
System Address Space
 bus ID: 11 address type: memory address
 address base: 0xe8000000
 address range: 0x4300000
--
System Address Space
 bus ID: 13 address type: memory address
 address base: 0xec300000
 address range: 0x100000
--
System Address Space
 bus ID: 11 address type: I/O address
 address base: 0xd000
 address range: 0x2000
--
System Address Space
 bus ID: 13 address type: I/O address
 address base: 0xf000
 address range: 0x1000
--
System Address Space
 bus ID: 11 address type: I/O address
 address base: 0x0
 address range: 0xd000
--
System Address Space
 bus ID: 14 address type: memory address
 address base: 0xd0000
 address range: 0x4000
--
System Address Space
 bus ID: 14 address type: memory address
 address base: 0xe0000000
 address range: 0x2100000
--
System Address Space
 bus ID: 15 address type: memory address
 address base: 0xe2100000
 address range: 0x0
--
System Address Space
 bus ID: 14 address type: I/O address
 address base: 0xf000
 address range: 0x1000
--
System Address Space
 bus ID: 14 address type: I/O address
 address base: 0x0
 address range: 0xf000
--
System Address Space
 bus ID: 16 address type: memory address
 address base: 0xd0000
 address range: 0x4000
--
System Address Space
 bus ID: 16 address type: memory address
 address base: 0xda000000
 address range: 0x1100000
--
System Address Space
 bus ID: 17 address type: memory address
 address base: 0xdb100000
 address range: 0x0
--
System Address Space
 bus ID: 16 address type: I/O address
 address base: 0xf000
 address range: 0x1000
--
System Address Space
 bus ID: 16 address type: I/O address
 address base: 0x0
 address range: 0xf000
--
System Address Space
 bus ID: 18 address type: memory address
 address base: 0xd0000
 address range: 0x4000
--
System Address Space
 bus ID: 18 address type: memory address
 address base: 0xdc000000
 address range: 0x2100000
--
System Address Space
 bus ID: 19 address type: memory address
 address base: 0xde100000
 address range: 0x0
--
System Address Space
 bus ID: 18 address type: I/O address
 address base: 0xf000
 address range: 0x1000
--
System Address Space
 bus ID: 18 address type: I/O address
 address base: 0x0
 address range: 0xf000
--
Bus Heirarchy
 bus ID: 1 bus info: 0x00 parent bus ID: 0
--
Bus Heirarchy
 bus ID: 20 bus info: 0x01 parent bus ID: 0
--
Bus Heirarchy
 bus ID: 21 bus info: 0x01 parent bus ID: 3
--
Bus Heirarchy
 bus ID: 6 bus info: 0x00 parent bus ID: 5
--
Bus Heirarchy
 bus ID: 22 bus info: 0x01 parent bus ID: 5
--
Bus Heirarchy
 bus ID: 9 bus info: 0x00 parent bus ID: 8
--
Bus Heirarchy
 bus ID: 23 bus info: 0x01 parent bus ID: 8
--
Bus Heirarchy
 bus ID: 12 bus info: 0x00 parent bus ID: 11
--
Bus Heirarchy
 bus ID: 24 bus info: 0x01 parent bus ID: 11
--
Bus Heirarchy
 bus ID: 25 bus info: 0x01 parent bus ID: 14
--
Bus Heirarchy
 bus ID: 26 bus info: 0x01 parent bus ID: 16
--
Bus Heirarchy
 bus ID: 27 bus info: 0x01 parent bus ID: 18
--
Compatibility Bus Address
 bus ID: 0 address modifier: add
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 0 address modifier: add
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 2 address modifier: subtract
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 2 address modifier: subtract
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 3 address modifier: add
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 3 address modifier: add
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 4 address modifier: subtract
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 4 address modifier: subtract
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 5 address modifier: add
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 5 address modifier: add
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 7 address modifier: subtract
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 7 address modifier: subtract
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 8 address modifier: add
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 8 address modifier: add
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 10 address modifier: subtract
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 10 address modifier: subtract
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 11 address modifier: add
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 11 address modifier: add
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 13 address modifier: subtract
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 13 address modifier: subtract
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 14 address modifier: add
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 14 address modifier: add
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 15 address modifier: subtract
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 15 address modifier: subtract
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 16 address modifier: add
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 16 address modifier: add
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 17 address modifier: subtract
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 17 address modifier: subtract
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 18 address modifier: add
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 18 address modifier: add
 predefined range: 0x00000001
--
Compatibility Bus Address
 bus ID: 19 address modifier: subtract
 predefined range: 0x00000000
--
Compatibility Bus Address
 bus ID: 19 address modifier: subtract
 predefined range: 0x00000001

you need to modify the source to handle OEM data!


 Unable to find PIRQ table.

===============================================================================


-------------------------------------------------------------------------------



---------------
scanpci output:


pci bus 0x0000 cardnum 0x0a function 0x00: vendor 0x1039 device 0x6326
 SiS 6326

pci bus 0x0000 cardnum 0x0b function 0x00: vendor 0x1077 device 0x1020
 QLogic ISP1020

pci bus 0x0000 cardnum 0x0c function 0x00: vendor 0x1011 device 0x0026
 Digital  Device unknown

pci bus 0x0000 cardnum 0x0e function 0x00: vendor 0x8086 device 0x7110
 Intel 82371AB PIIX4 ISA

pci bus 0x0000 cardnum 0x0e function 0x01: vendor 0x8086 device 0x7111
 Intel 82371AB PIIX4 IDE

pci bus 0x0000 cardnum 0x0e function 0x02: vendor 0x8086 device 0x7112
 Intel 82371AB PIIX4 USB

pci bus 0x0000 cardnum 0x0e function 0x03: vendor 0x8086 device 0x7113
 Intel 82371AB PIIX4 ACPI

pci bus 0x0000 cardnum 0x10 function 0x00: vendor 0x8086 device 0x84ca
 Intel  Device unknown

pci bus 0x0000 cardnum 0x12 function 0x00: vendor 0x8086 device 0x84cb
 Intel  Device unknown

pci bus 0x0000 cardnum 0x14 function 0x00: vendor 0x8086 device 0x84cb
 Intel  Device unknown

pci bus 0x0001 cardnum 0x04 function 0x00: vendor 0x9004 device 0x6915
 Adaptec  Device unknown

pci bus 0x0001 cardnum 0x05 function 0x00: vendor 0x9004 device 0x6915
 Adaptec  Device unknown

pci bus 0x0001 cardnum 0x06 function 0x00: vendor 0x9004 device 0x6915
 Adaptec  Device unknown

pci bus 0x0001 cardnum 0x07 function 0x00: vendor 0x9004 device 0x6915
 Adaptec  Device unknown

pci bus 0x0002 cardnum 0x0f function 0x00: vendor 0x1077 device 0x2300
 QLogic  Device unknown


-----------------
/proc/pci output:

PCI devices found:
  Bus  0, device  10, function  0:
    VGA compatible controller: Silicon Integrated S 86C326 5598/6326 (rev 11).
      IRQ 23.
      Master Capable.  Latency=255.  Min Gnt=2.
      Prefetchable 32 bit memory at 0xfc000000 [0xfc7fffff].
      Non-prefetchable 32 bit memory at 0xfc800000 [0xfc80ffff].
      I/O at 0xec80 [0xecff].
  Bus  0, device  11, function  0:
    SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SC (rev 5).
      IRQ 19.
      Master Capable.  Latency=248.  
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xfcb00000 [0xfcb00fff].
  Bus  0, device  12, function  0:
    PCI bridge: Digital Equipment Co DECchip 21154 (rev 2).
      Master Capable.  Latency=255.  Min Gnt=3.
  Bus  0, device  14, function  0:
    ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4  (rev 2).
  Bus  0, device  14, function  1:
    IDE interface: Intel Corp. 82371AB/EB/MB PIIX4  (rev 1).
      I/O at 0xe0 [0xef].
  Bus  0, device  14, function  2:
    USB Controller: Intel Corp. 82371AB/EB/MB PIIX4  (rev 1).
      I/O at 0x1000 [0x101f].
  Bus  0, device  14, function  3:
    Bridge: Intel Corp. 82371AB/EB/MB PIIX4  (rev 2).
  Bus  0, device  16, function  0:
    Host bridge: Intel Corp. 450NX - 82451NX Memo (rev 3).
  Bus  2, device  15, function  0:
    Fibre Channel: QLogic Corp. QLA2300 64-bit FC-AL (rev 1).
      IRQ 28.
      Master Capable.  Latency=248.  Min Gnt=64.
      I/O at 0xfc00 [0xfcff].
      Non-prefetchable 32 bit memory at 0xfd300000 [0xfd300fff].
  Bus  0, device  18, function  0:
    Host bridge: Intel Corp. 450NX - 82454NX/8446 (rev 4).
      Master Capable.  Latency=32.  
  Bus  0, device  20, function  0:
    Host bridge: Intel Corp. 450NX - 82454NX/8446 (#2) (rev 4).
      Master Capable.  Latency=32.  
  Bus  1, device   4, function  0:
    Ethernet controller: Adaptec ANA620xx/ANA69011A (rev 3).
      IRQ 15.
      Master Capable.  Latency=252.  Min Gnt=9.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xfc900000 [0xfc97ffff].
      I/O at 0xdc00 [0xdcff].
  Bus  1, device   5, function  0:
    Ethernet controller: Adaptec ANA620xx/ANA69011A (#2) (rev 3).
      IRQ 13.
      Master Capable.  Latency=252.  Min Gnt=9.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xfc980000 [0xfc9fffff].
      I/O at 0xd800 [0xd8ff].
  Bus  1, device   6, function  0:
    Ethernet controller: Adaptec ANA620xx/ANA69011A (#3) (rev 3).
      IRQ 11.
      Master Capable.  Latency=252.  Min Gnt=9.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xfca00000 [0xfca7ffff].
      I/O at 0xd400 [0xd4ff].
  Bus  1, device   7, function  0:
    Ethernet controller: Adaptec ANA620xx/ANA69011A (#4) (rev 3).
      IRQ 7.
      Master Capable.  Latency=252.  Min Gnt=9.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xfca80000 [0xfcafffff].
      I/O at 0xd000 [0xd0ff].


------------------------
/proc/interrupts output:

           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9       CPU10       CPU11       CPU12       CPU13       CPU14       CPU15       CPU16       CPU17       CPU18       CPU19       CPU20       CPU21       CPU22       CPU23       CPU24       CPU25       CPU26       CPU27       CPU28       CPU29       CPU30       CPU31       
  0:    4101332          1          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  local-APIC-edge  timer
  2:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          XT-PIC  cascade
  4:          0          1        402          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0    IO-APIC-edge  serial
 15:          0          1      12910          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth0
 19:          0          1       5723          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  qlogicisp
NMI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0 
LOC:    3987347    3986480    3986656    3986637    3986736    3986716    3986696    3986676    3986915    3986895    3986875    3986853    3986962    3986941    3986920    3986899    3986612    3986591    3986570    3986549    3986699    3986679    3986658    3986636    3986313    3986291    3986270    3986250    3986205    3986184    3986164    3986142 
ERR:          0
MIS:          0

===============================================================================

The missing OEM table is reported in dmesg:

OEM ID: IBM NUMA Product ID: SBB          Found an OEM MPC table at   7012ec - p
arsing it ... 
Translation: record 0, type 1, quad 0, global 3, local 3
Translation: record 1, type 1, quad 0, global 1, local 1
Translation: record 2, type 1, quad 0, global 1, local 1
Translation: record 3, type 1, quad 0, global 1, local 1
Translation: record 4, type 1, quad 1, global 1, local 3
Translation: record 5, type 1, quad 1, global 1, local 1
Translation: record 6, type 1, quad 1, global 1, local 1
Translation: record 7, type 1, quad 1, global 1, local 1
Translation: record 8, type 1, quad 2, global 1, local 3
Translation: record 9, type 1, quad 2, global 1, local 1
Translation: record 10, type 1, quad 2, global 1, local 1
Translation: record 11, type 1, quad 2, global 1, local 1
Translation: record 12, type 1, quad 3, global 1, local 3
Translation: record 13, type 1, quad 3, global 1, local 1
Translation: record 14, type 1, quad 3, global 1, local 1
Translation: record 15, type 1, quad 3, global 1, local 1
Translation: record 16, type 1, quad 4, global 1, local 3
Translation: record 17, type 1, quad 4, global 1, local 1
Translation: record 18, type 1, quad 4, global 1, local 1
Translation: record 19, type 1, quad 4, global 1, local 1
Translation: record 20, type 1, quad 5, global 1, local 3
Translation: record 21, type 1, quad 5, global 1, local 1
Translation: record 22, type 1, quad 5, global 1, local 1
Translation: record 23, type 1, quad 5, global 1, local 1
Translation: record 24, type 1, quad 6, global 1, local 3
Translation: record 25, type 1, quad 6, global 1, local 1
Translation: record 26, type 1, quad 6, global 1, local 1
Translation: record 27, type 1, quad 6, global 1, local 1
Translation: record 28, type 1, quad 7, global 1, local 3
Translation: record 29, type 1, quad 7, global 1, local 1
Translation: record 30, type 1, quad 7, global 1, local 1
Translation: record 31, type 1, quad 7, global 1, local 1
Translation: record 32, type 3, quad 0, global 0, local 0
Translation: record 33, type 3, quad 0, global 1, local 1
Translation: record 34, type 3, quad 0, global 2, local 2
Translation: record 35, type 4, quad 0, global 20, local 18
Translation: record 36, type 3, quad 1, global 3, local 0
Translation: record 37, type 3, quad 1, global 4, local 1
Translation: record 38, type 4, quad 1, global 21, local 18
Translation: record 39, type 3, quad 2, global 5, local 0
Translation: record 40, type 3, quad 2, global 6, local 1
Translation: record 41, type 3, quad 2, global 7, local 2
Translation: record 42, type 4, quad 2, global 22, local 18
Translation: record 43, type 3, quad 3, global 8, local 0
Translation: record 44, type 3, quad 3, global 9, local 1
Translation: record 45, type 3, quad 3, global 10, local 2
Translation: record 46, type 4, quad 3, global 23, local 18
Translation: record 47, type 3, quad 4, global 11, local 0
Translation: record 48, type 3, quad 4, global 12, local 1
Translation: record 49, type 3, quad 4, global 13, local 2
Translation: record 50, type 4, quad 4, global 24, local 18
Translation: record 51, type 3, quad 5, global 14, local 0
Translation: record 52, type 3, quad 5, global 15, local 1
Translation: record 53, type 4, quad 5, global 25, local 18
Translation: record 54, type 3, quad 6, global 16, local 0
Translation: record 55, type 3, quad 6, global 17, local 1
Translation: record 56, type 4, quad 6, global 26, local 18
Translation: record 57, type 3, quad 7, global 18, local 0
Translation: record 58, type 3, quad 7, global 19, local 1
Translation: record 59, type 4, quad 7, global 27, local 18
Translation: record 60, type 2, quad 0, global 13, local 14
Translation: record 61, type 2, quad 0, global 14, local 13
Translation: record 62, type 2, quad 1, global 15, local 14
Translation: record 63, type 2, quad 1, global 16, local 13
Translation: record 64, type 2, quad 2, global 17, local 14
Translation: record 65, type 2, quad 2, global 18, local 13
Translation: record 66, type 2, quad 3, global 19, local 14
Translation: record 67, type 2, quad 3, global 20, local 13
Translation: record 68, type 2, quad 4, global 21, local 14
Translation: record 69, type 2, quad 4, global 22, local 13
Translation: record 70, type 2, quad 5, global 23, local 14
Translation: record 71, type 2, quad 5, global 24, local 13
Translation: record 72, type 2, quad 6, global 25, local 14
Translation: record 73, type 2, quad 6, global 26, local 13
Translation: record 74, type 2, quad 7, global 27, local 14
Translation: record 75, type 2, quad 7, global 28, local 13
