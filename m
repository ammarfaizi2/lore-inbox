Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUCXXst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCXXst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:48:49 -0500
Received: from chello062178006202.3.11.tuwien.teleweb.at ([62.178.6.202]:3456
	"EHLO flatline.ath.cx") by vger.kernel.org with ESMTP
	id S262285AbUCXXrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:47:01 -0500
Date: Thu, 25 Mar 2004 00:46:59 +0100
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, olh@suse.de
Subject: Re: 2.6.5-rc2-mm2
Message-ID: <20040324234659.GA1263@flatline.ath.cx>
References: <20040323232511.1346842a.akpm@osdl.org> <slrnc63mc2.18m.news_0403@flatline.ath.cx> <20040324130653.35cab65b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040324130653.35cab65b.akpm@osdl.org>
X-Request-PGP: subkeys.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> [040324 22:04]:
>Andreas Happe <news_0403@flatline.ath.cx> wrote:
>>what information would you need to solve that
>> problem?
>
>The sysrq-T output, if possible.  And your .config.

SysRq works, but the screen seems to be frozen (i.e. not updated), I've
got no seriell console at hand, will try booting without framebuffer
later.

As suggested by Olaf Hering I've checked init/main.c. It says
| 161:	if (sys_access("/init", 0) == 0)
| 162:		execute_command = "/init";
| 163:	else
| 164:		prepare_namespace();

thus I think, that the sources should be o.k. I've also rebuild the
kernel using a `make clean` first.

my .config should be attached.

	--Andreas
