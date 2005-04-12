Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVDLScy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVDLScy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVDLScy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:32:54 -0400
Received: from mail.aknet.ru ([217.67.122.194]:58385 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262316AbVDLRwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:52:51 -0400
Message-ID: <425C0AFE.9080106@aknet.ru>
Date: Tue, 12 Apr 2005 21:53:02 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: 2.6.12-rc2-mm3 (ACPI build problem)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
Fails to compile with
!CONFIG_ACPI && CONFIG_SMP.
CONFIG_SMP sets CONFIG_X86_HT,
which sets CONFIG_ACPI_BOOT,
but that fails without CONFIG_ACPI:

  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:96: error: syntax error before ‘acpi_sci_flags’
arch/i386/kernel/setup.c:96: warning: type defaults to ‘int’ in declaration of ‘acpi_sci_flags’
arch/i386/kernel/setup.c:96: warning: data definition has no type or storage class
arch/i386/kernel/setup.c: In function ‘parse_cmdline_early’:
arch/i386/kernel/setup.c:811: error: request for member ‘trigger’ in something not a structure or union
arch/i386/kernel/setup.c:814: error: request for member ‘trigger’ in something not a structure or union
arch/i386/kernel/setup.c:817: error: request for member ‘polarity’ in something not a structure or union
arch/i386/kernel/setup.c:820: error: request for member ‘polarity’ in something not a structure or union

