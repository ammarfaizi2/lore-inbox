Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317015AbSEWVga>; Thu, 23 May 2002 17:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317016AbSEWVg3>; Thu, 23 May 2002 17:36:29 -0400
Received: from daimi.au.dk ([130.225.16.1]:47723 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317015AbSEWVg3>;
	Thu, 23 May 2002 17:36:29 -0400
Message-ID: <3CED60D7.9E5032D7@daimi.au.dk>
Date: Thu, 23 May 2002 23:36:23 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@redhat.com
Subject: Re: [PATCH] 2.4.19-pre8 vm86 smp locking fix
In-Reply-To: <20020523165105.A27881@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> arch/i386/kernel/vm86.c performs page table operations without obtaining
> any locks.  This patch obtains page_table_lock around the the table walk
> and modification.

This patch can also be applied against 2.4.19-pre8-ac5.
The patch command does report:
patching file arch/i386/kernel/vm86.c
Hunk #1 succeeded at 124 (offset 27 lines).

Since this missing lock is completely unrelated to the
other bugfixes in vm86 I don't expect any bad interactions.

The pagetable access in arch/i386/kernel/vm86.c is related
to another access in arch/i386/mm/fault.c. Did anybody
verify that the other file does correct locking?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
