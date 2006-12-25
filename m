Return-Path: <linux-kernel-owner+w=401wt.eu-S1754454AbWLYL07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbWLYL07 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 06:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754466AbWLYL07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 06:26:59 -0500
Received: from javad.com ([216.122.176.236]:2299 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754454AbWLYL07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 06:26:59 -0500
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
Date: Mon, 25 Dec 2006 14:26:42 +0300
In-Reply-To: <552766292581216610@wsc.cz> (Jiri Slaby's message of "Sat, 23
 Dec
	2006 02:35:46 +0100 (CET)")
Message-ID: <87r6uo8bd9.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

> osv@javad.com wrote:
>> Hi Jiri,
>> 
>> I've figured out that both old and new mxser drivers have two similar
>> problems:
>> 
>> 1. When there are data coming to a port, sometimes opening of the port
>>    entirely locks the box. This is quite reproducible. Any idea what's
>>    wrong and how can I help to debug it?
>
> Could you test the patch below, if something changes?

I'm preparing to test it. However, it seems that my version of
mxser_new.c got out of sync with your one:

osv@osv mxser_new$ patch -p3 < lock.patch
patching file mxser_new.c
Hunk #1 succeeded at 1900 (offset -368 lines).
Hunk #2 succeeded at 1968 (offset -354 lines).
osv@osv mxser_new$ patch -p3 < rmmod.patch
patching file mxser.c
Hunk #1 succeeded at 711 with fuzz 2 (offset -6 lines).
patching file mxser_new.c
Hunk #1 succeeded at 705 with fuzz 2 (offset -1985 lines).
osv@osv mxser_new$

I'll try this one anyway, but could you please either tell me where to
get the version you are using, or just send it to me by mail?

BTW, when system hangs, SysRq magic doesn't work anymore.

-- Sergei.
