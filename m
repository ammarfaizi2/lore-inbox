Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129224AbRBGTad>; Wed, 7 Feb 2001 14:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130186AbRBGTaX>; Wed, 7 Feb 2001 14:30:23 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:56836 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129224AbRBGTaP>; Wed, 7 Feb 2001 14:30:15 -0500
Date: Wed, 7 Feb 2001 13:24:26 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jakub Jelinek <jakub@redhat.com>, Gregory Maxwell <greg@linuxpower.cx>,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [OT] Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207132426.A28159@vger.timpanogas.org>
In-Reply-To: <20010207131439.A28015@vger.timpanogas.org> <E14QaAX-00016d-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14QaAX-00016d-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 07, 2001 at 07:22:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii

On Wed, Feb 07, 2001 at 07:22:19PM +0000, Alan Cox wrote:
> > In file included from init.c:30:
> > ../../prolog.h:344:8: invalid #ident
> 
> It doesnt say #ident isnt supported it says your use of it is invalid. What
> precisely does that line read ?

JJ tried it and it worked on some version he was running, but fails on 
the 7.1 build.  Here is the code that produces the offending messages.
I got an "invalid keyword" (sorry, it was not "unknown" but "invalid", that was 
a different error message on gcc 2.96).

Jeff



--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prolog.h"

/* $Id: prolog.h,v 3.37 2000/11/16 14:30:02 hasv Exp $  */

/*******************************************************************************
 *                                                                             *
 * Copyright (C) 1993 - 2000                                                   * 
 *         Dolphin Interconnect Solutions AS                                   *
 *                                                                             *
 * This program is free software; you can redistribute it and/or modify        * 
 * it under the terms of the GNU General Public License as published by        *
 * the Free Software Foundation; either version 2 of the License,              *
 * or (at your option) any later version.                                      *
 *                                                                             *
 * This program is distributed in the hope that it will be useful,             *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of              *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               *
 * GNU General Public License for more details.                                *
 *                                                                             *
 * You should have received a copy of the GNU General Public License           *
 * along with this program; if not, write to the Free Software                 *
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. *
 *                                                                             *
 *                                                                             *
 *******************************************************************************/ 


/*
 * ============================================================================================
 * This a prolog file which shall be included in all C and H files as the very, VERY , V E R Y,
 * first file include, more, the include statement for this should be first statement in the
 * file, including preprocessor statements.
 * 
 * Expected predefines:
 * 
 * One of 
 * _IRM_INTERNAL_:      Set if this file is included as a part IRM source.
 * _SISCI_INTERNAL_:    Set if this file is included as a part SISCI source.
 * 
 * One of:
 * -------
 * OS_IS_SOLARIS:       Set if the target os is Solaris.
 * OS_IS_NT:            Set if the target os is WIN NT.
 * OS_IS_LINUX:         Set if the target os is Linux.
 * OS_IS_LYNX:          Set if the target os is LYNX.
 * 
 * (Set by OS specific file in MAKE subdirectory).
 * 
 * One of:
 * -------
 * CPU_ARCH_IS_X86:     Set if target architecture is INTEL X86.
 * CPU_ARCH_IS_SPARC:   Set if target architecture is SPARC (32 bit).
 * CPU_ARCH_IS_SPARC64: Set if target architecture is SPARC (64 bit).
 * CPU_ARCH_IS_ALPHA:   Set if target architechture is ALPHA
 * CPU_ARCH_IS_PPC:     Set if target architechture is PowerPC
 *
 * (Set by CPU Architecture specific file in MAKE subdirectory).
 * 
 * One of:
 * -------
 * ADAPTER_IS_SBUS2:   Set if target adapter is sbus2.
 * ADAPTER_IS_PCI1:    Set if target adapter is pci1.
 * ADAPTER_IS_PSB64:   Set if target adapter is psb64.
 * ADAPTER_IS_PSB66:   Set if target adapter is psb66
 *
 * (Set by ADAPTER specific file in MAKE subdirectory).
 * 
 * ============================================================================================
 */

#ifndef _SCI_IRM_PROLOG_H_
#define _SCI_IRM_PROLOG_H_

#ifndef _IRM_INTERNAL_
#define _IRM_INTERNAL_ 1
#endif

#if _IRM_INTERNAL_

/*
 * ==============================================================
 * Section for general IRM compilation flags 
 *
 * ==============================================================
 */
#define SESSION_HEARTBEATS_DISABLE_SUPPORT      1
#define LINK_WATCHDOG_DISABLE_SUPPORT           1


/*
 * ==============================================================
 * PCI1 (PSB32) - D308 / D310 
 *
 * ==============================================================
 */
#if ADAPTER_IS_PCI1

#define PCI    1  
#define PSB2   1 /* old to be changed to PSB32 */ 
#define PCI1   1 /* old to be changed to PSB32 */
#define PCI2   1 /* old to be changed to PSB32 */
#define PSB32  1

#define PSB1_REV_B                1
#define PSB1_REV_C                1
#define PSB1_REV_D                1

#endif


/*
 * ==============================================================
 * PSB64 - D32x
 *
 * ==============================================================
 */
#if ADAPTER_IS_PSB64

#define PCI                       1
#define PSB64                     1

#endif

/*
 * ==============================================================
 * PSB66 - D33x
 *
 * ==============================================================
 */
#if ADAPTER_IS_PSB66

#define PCI                       1 
#define PSB66                     1

#endif


/*
 * ============================================================================================
 * SOLARIS specific defines
 * (Should really be in "os/prolog.h" since they are Solaris Specific.)
 * ============================================================================================
 */
#if OS_IS_SOLARIS

#define OS_ADAPTER_QUERIES             1

#define RESTRICTED_CONSOLE_LOG         1
#define NOLOCK_HEARTBEATS              1

#define LARGE_DMA_QUEUE                1
#if CPU_ARCH_IS_X86


#define _USE_NEW_SOLARIS_DDI_INTERFACE 1
#define _OBSCURE_ALIGN_RESTRICTION     1
#define _UNIQ_DMA_HANDLE               1
#define USE_SOFTINTR                   1
#endif

#if SOLARIS_27
#define SOL27 1
#endif

#define IDENT_IS_SUPPORTED             1


#endif

/*
 * ============================================================================================
 * NT specific defines
 * (Should really be in "os/prolog.h" since they are OS Specific.)
 * ============================================================================================
 */
#if OS_IS_NT
#define ENABLE_PSB1_REV_D_LOOPBACK_ON_BLINK 1
#endif

/*
 * ============================================================================================
 * Linux specific defines
 * (Should really be in "os/prolog.h" since they are OS Specific.)
 * ============================================================================================
 */
#if OS_IS_LINUX
#define Linux 1
#define LINUX 1
#define MODULE 1
#define WRITE_COMBINING_SUPPORT 1
#define ENABLE_PSB1_REV_D_LOOPBACK_ON_BLINK 1
#define IDENT_IS_SUPPORTED             1
/* 
 * MT_DMA and MT_FLAGINT are still defined in mkIRM.def even if they are OS specific.
 * The lines below will undefinde them 
 */
#undef MT_DMA
#undef MT_FLAGINT
#endif

/*
 * ============================================================================================
 * Tru64 specific defines
 * (Should really be in "os/prolog.h" since they are OS Specific.)
 * ============================================================================================
 */
#if OS_IS_TRU64
#define BUILD_NAME     "Alpha 1"

/* 
 * MT_DMA and MT_FLAGINT are still defined in mkIRM.def even if they are OS specific.
 * The lines below will undefinde them 
 */
#undef MT_DMA 
#undef MT_FLAGINT

#endif

/*
 * ============================================================================================
 * LynxOS  specific defines
 * (Should really be in "os/prolog.h" since they are OS Specific.)
 * ============================================================================================
 */
#if OS_IS_LYNX
#define BUILD_NAME     "Alpha 1"
/* 
 * MT_DMA and MT_FLAGINT are still defined in mkIRM.def even if they are OS specific.
 * The lines below will undefinde them 
 */
#undef MT_DMA 
#undef MT_FLAGINT

#if CPU_ARCH_IS_PPC
#define __drm__ 1  
#endif

/* 
 * Uncomment statement below to enable dynamic IRM installation. Static installation is
 * required for SISCI support - Lynx 3.0.1
 */
/* #define DLDD 1 */  

/*
 * Uncomment the statement below to enable
 * Hot Swap Support on Lynx 3.0.1 (for PPC) or Lynx 3.1 (for X86 and/or PPC)
 *  
 * NOTE : DON'T ENABLE HS_SUPPORT IF __drm__ IS NOT DEFINED
 */
#define HS_SUPPORT  1

#endif

/*
 * ============================================================================================
 * VXWORKS specific defines
 * (Should really be in "os/prolog.h" since they are OS Specific.)
 * ============================================================================================
 */

#if OS_IS_VXWORKS
#define HS_SUPPORT  1

/* 
 * MT_DMA and MT_FLAGINT are still defined in mkIRM.def even if they are OS specific.
 * The lines below will undefinde them 
 */
#undef MT_DMA
#undef MT_FLAGINT
#endif

/*
 * ============================================================================================
 * Intel X86 specific defines
 * (Should really be in "cpu/prolog.h" since they are architecture Specific.)
 * ============================================================================================
 */
#if CPU_ARCH_IS_X86
#ifndef LITTLE_ENDIAN
#define LITTLE_ENDIAN 1
#define _X86_                          1
#endif
#endif

/*
 * ============================================================================================
 * ALPHA Architecture specific defines
 * (Should really be in "cpu/prolog.h" since they are architecture Specific.)
 * ============================================================================================
 */
#if CPU_ARCH_IS_ALPHA
#ifndef LITTLE_ENDIAN
#define LITTLE_ENDIAN 1
#endif

#define CPU_WORD_IS_64_BIT 1

#endif


/*
 * ============================================================================================
 * PowerPC specific defines
 * (Should really be in "cpu/prolog.h" since they are architecture Specific.)
 * ============================================================================================
 */
#if CPU_ARCH_IS_PPC
#ifndef BIG_ENDIAN
#define BIG_ENDIAN 1
#define __powerpc__ 1

#endif
#endif


/*
 * ============================================================================================
 * Sparc specific defines
 * (Should really be in "cpu/prolog.h" since they are architecture Specific.)
 * ============================================================================================
 */
#if CPU_ARCH_IS_SPARC
#ifndef BIG_ENDIAN
#define BIG_ENDIAN 1
#endif
#endif

/*
 * ============================================================================================
 * Consistency checks 
 * ============================================================================================
 */
#if (LITTLE_ENDIAN && BIG_ENDIAN) || !(LITTLE_ENDIAN || BIG_ENDIAN)
#error Either LITTLE_ENDIAN or BIG_ENDIAN must be defined. Not both.
#endif

/*
 * ============================================================================================
 *  Add the CVS Id to the comment section of the binary file.
 * ============================================================================================
 */

#ifdef CVSID

#ifdef IDENT_IS_SUPPORTED
#ident CVSID              
#ident "@(#)$Id: prolog.h,v 3.37 2000/11/16 14:30:02 hasv Exp $"
static char cvsid[] = CVSID;
#else
static char cvsid[] = CVSID;
#endif
#else
#error CVSID have to be defined
#endif

#endif _IRM_INTERNAL_
#endif  _SCI_IRM_PROLOG_H_





--ew6BAiZeqk4r7MaW--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
