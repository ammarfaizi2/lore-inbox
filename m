Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVABOhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVABOhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 09:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVABOhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 09:37:15 -0500
Received: from fyrebird.net ([217.70.144.192]:42916 "HELO fyrebird.net")
	by vger.kernel.org with SMTP id S261231AbVABOhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 09:37:06 -0500
X-Qmail-Scanner-Mail-From: lethalman@fyrebird.net via fyrebird
X-Qmail-Scanner: 1.23 (Clear:RC:0(62.11.84.211):. Processed in 2.062093 secs)
Message-ID: <41D80446.50206@fyrebird.net>
Date: Sun, 02 Jan 2005 15:25:10 +0100
From: Lethalman <lethalman@fyrebird.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Disable creation of coredump file
References: <20050102142735.58501.qmail@web53904.mail.yahoo.com>
In-Reply-To: <20050102142735.58501.qmail@web53904.mail.yahoo.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gan_xiao_jun@yahoo.com wrote:
> Hi,
> 
> I want to disable the creation of the core dump even
> after set "ulimit -c XXXX"
> 
> I modify 
> include/asm-i386/resource.h
> the data structure INIT_RLIMITS
> the 4th elements(RLIMIT_CORE)
> from 
> rlim_cur = 0, rlim_max = RLIMINFINITY
> to 
> rlim_cur = 0, rlim_max = 0
> But core dump still be created.
> 
> Thanks in advance.
> gan
> 

Undefining USE_ELF_CORE_DUMP from asm headers (like 
include/asm-i386/elf.h and asm/elf.h) should disable core dumping.

-- 
www.iosn.it * Amministratore Italian Open Source Network
www.fyrebird.net * Fyrebird Hosting Provider - Technical Department
