Return-Path: <linux-kernel-owner+w=401wt.eu-S1754495AbWLYNmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbWLYNmL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 08:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbWLYNmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 08:42:11 -0500
Received: from javad.com ([216.122.176.236]:3491 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495AbWLYNmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 08:42:10 -0500
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
Date: Mon, 25 Dec 2006 16:41:56 +0300
In-Reply-To: <552766292581216610@wsc.cz> (Jiri Slaby's message of "Sat, 23
 Dec
	2006 02:35:46 +0100 (CET)")
Message-ID: <871wmom6sb.fsf@javad.com>
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

Something did change. Now it becomes rather difficult to get the box to
hang, though not impossible. Another thing that changed is that now I
can see [parts of] oopses on screen. I've got two pictures of the screen
with different oopses. If you need them, let me know and I'll send them
to you in a separate mail not to pollute lkml with JPEGs.

One of these oopses happened on kernel with lock debugging enabled, but
I can't see anything relevant in dmesg log after resetting the box.

SysRq magic still doesn't work after hang.

As for the problem with module unloading when port is open, your another
patch does fix it indeed.

-- Sergei.

