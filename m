Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268032AbUHKMBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUHKMBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUHKMBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:01:36 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:19104 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S268032AbUHKMBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:01:34 -0400
Message-ID: <411A0A9C.70008@free.fr>
Date: Wed, 11 Aug 2004 14:01:32 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
References: <41189098.4000400@free.fr> <4118A500.1080306@free.fr> <1092151779.5028.40.camel@dhcppc4> <20040810154446.GB22863@hell.org.pl>
In-Reply-To: <20040810154446.GB22863@hell.org.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karol Kozimor wrote:

> Here's more about my problem: it seems 2.6.8-rc3-mm1 sometimes manages to
> boot here. Even so, kacpid completely hogs the CPU. dmesg and debug output
> is at http://hell.org.pl/~sziwan/2.6.8-rc3-mm1.report (300 kB), DSDT is at
> http://hell.org.pl/~sziwan/l3800c.dsl. Note the odd thermal zone output
> (did somebody mention TZ problems?). Call trace below.
> Best regards,

I've seen this problem long before 2.6.8-rc3-mm1 on LKML (e.g. 
http://www.ussg.iu.edu/hypermail/linux/kernel/0406.2/0040.html) and on 
different laptop (Dell). So may be, there is a deadlock window somephere 
that just open ups or close depending on :
	- Compiler,
	- Unrelated patches,
	- ...

I guess, hunting will be fun... I would start by the thermal problem as 
it seems to be hit also by a few people... I whish I could have kdb 
integrated to see what happens but on mm tree applying it is too painfull...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



