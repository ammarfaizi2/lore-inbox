Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSKOAWF>; Thu, 14 Nov 2002 19:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSKOAWF>; Thu, 14 Nov 2002 19:22:05 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:19135 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S265373AbSKOAWD>;
	Thu, 14 Nov 2002 19:22:03 -0500
Date: Fri, 15 Nov 2002 01:28:54 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Alessandro Bono <a.bono@libero.it>
Subject: binutils bug/requirements
Message-ID: <20021115002854.GE3376@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

A little bug report haunting...
A user of -jam2 kernel reported me an strange error:

csum.S:65: invalid format `#line' directive

(in arch/i386/lib)

It is one of the files created by the fast-csum-D patch bt Denis Vlasenko.

The problem looks like as is taking the '# 2-' in:

30:
    # 2-aligned, but not 4-aligned
    cmpl    $3, %ecx
    jbe 60f

as a #line directive, like:

# 36 "csum.S"

Versions is his box (debian woody):
Gnu C                  2.95.4
binutils             2.12.90.0.1-4

It works for me:
gcc (GCC) 3.2 (Mandrake Linux 9.1 3.2-3mdk)
GNU assembler 2.13.90.0.8 20021008

Is is supposed to work ? Is it a bug in binutils ?
Obvious solution is to change it to something like

    # Remark: 2-aligned.....

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam2 (gcc 3.2 (Mandrake Linux 9.1 3.2-3mdk))
