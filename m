Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSLQKff>; Tue, 17 Dec 2002 05:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSLQKff>; Tue, 17 Dec 2002 05:35:35 -0500
Received: from fep01.superonline.com ([212.252.122.40]:24793 "EHLO
	fep01.superonline.com") by vger.kernel.org with ESMTP
	id <S264886AbSLQKfe>; Tue, 17 Dec 2002 05:35:34 -0500
Message-ID: <3DFEFD37.2020104@superonline.com>
Date: Tue, 17 Dec 2002 12:32:23 +0200
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac2
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For IPMI to compile, I needed this include
in ipmi_watchdog.c :

  #include <linux/nmi.h>
  #include <linux/reboot.h>
  #ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/fixmap.h>
  #include <asm/apic.h>
  #endif

  /*

Regards.

