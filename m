Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283038AbRLDKqC>; Tue, 4 Dec 2001 05:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283042AbRLDKpw>; Tue, 4 Dec 2001 05:45:52 -0500
Received: from t2.redhat.com ([199.183.24.243]:24308 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S283038AbRLDKpo>; Tue, 4 Dec 2001 05:45:44 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011204104047.A18147@flint.arm.linux.org.uk> 
In-Reply-To: <20011204104047.A18147@flint.arm.linux.org.uk>  <m3r8qcagt7.fsf@linux.local> <E16AIZ8-0008Re-00@the-village.bc.nu> <12969.1007315617@redhat.com> <m3r8qcagt7.fsf@linux.local> <25163.1007370678@redhat.com> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: Christoph Rohland <cr@sap.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 10:45:04 +0000
Message-ID: <7847.1007462704@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  We actually still map the pages as cached, but when update_mmu_cache
> detects that a page has been mmapped more than once, we ensure that
> the other mappings in the current mm will fault when accessed.

Oooh. Can you do that without having phys->virt lookup? And what about 
mappings in other mms? Or are the ARM caches so broken that you have to 
flush the whole damn thing on mm switch anyway?

VIVT. Urgh.

--
dwmw2


