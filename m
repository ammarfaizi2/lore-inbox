Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWDAL2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWDAL2i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 06:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWDAL2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 06:28:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:15611 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750808AbWDAL2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 06:28:38 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: cell compile fixes.
Date: Sat, 1 Apr 2006 13:28:25 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060401045309.GA22149@redhat.com>
In-Reply-To: <20060401045309.GA22149@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604011328.26032.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 01 April 2006 06:53 schrieb Dave Jones:
> Missing include for __NR_syscalls, and missing sys_splice() that
> causes build-time failure due to compile-time bounds check on
> spu_syscall_table.
>
> Signed-off-by: Dave Jones <davej@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

It's not always obvious if a syscall can be added to that list, e.g.
pselect6 could not because the SPU must not change the signal mask,
but splice belongs in there.

Thanks,
	Arnd <><
