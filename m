Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261378AbTCJGQ6>; Mon, 10 Mar 2003 01:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTCJGQ6>; Mon, 10 Mar 2003 01:16:58 -0500
Received: from franka.aracnet.com ([216.99.193.44]:26272 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261378AbTCJGQz>; Mon, 10 Mar 2003 01:16:55 -0500
Date: Sun, 09 Mar 2003 22:27:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Adam J. Richter" <adam@yggdrasil.com>, gone@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Message-ID: <73890000.1047277650@[10.10.2.4]>
In-Reply-To: <200303092305.PAA02985@adam.yggdrasil.com>
References: <200303092305.PAA02985@adam.yggdrasil.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Under linux-2.5.64bk5, CONFIG_X86_PC sets CONFIG_NUMA,
> which sets CONFIG_DISCONTIGMEM.  This causes the version of
> set_max_mapnr_init in arch/i386/mm/discontig.c to be compiled
> in (instead of the one from arch/i386/mm/init.c):
>
> Err, I meant 2.5.64bk4. 

Hmmm ... well I don't see bk4 on ftp.kernel.org, but the same
changes are in my tree ...  I've just checked it, and it doesn't 
do that for me. It should *allow* you to turn on CONFIG_NUMA 
(and that might be broken for PCs still) but it shouldn't be on 
by default ... could you check that you can still disable it?
Works for me ...

M.


config NUMA
        bool "Numa Memory Allocation Support"
        depends on (HIGHMEM64G && (X86_NUMAQ || (X86_SUMMIT && ACPI && !ACPI_HT_
ONLY))) || X86_PC

