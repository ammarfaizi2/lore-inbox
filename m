Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVD2QDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVD2QDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVD2QAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:00:50 -0400
Received: from [195.23.16.24] ([195.23.16.24]:35238 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262814AbVD2P7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:59:48 -0400
Message-ID: <427259F0.1080009@grupopie.com>
Date: Fri, 29 Apr 2005 16:59:44 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rnl@rnl.ist.utl.pt
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt> <20050429050833.6b3d805b.akpm@osdl.org> <200504291521.08711.pjvenda@rnl.ist.utl.pt>
In-Reply-To: <200504291521.08711.pjvenda@rnl.ist.utl.pt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Venda (SYSADM) wrote:
> On Friday 29 April 2005 13:08, Andrew Morton wrote:
> 
>>"Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt> wrote:
>>
>>>We've made some changes on our ftp server, and since that it's been
>>>crashing frequently (everyday) with a kernel panic.
>>>
>>>[...]
>>> The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634!"
>>
>>Strange.  It'd be interesting to try disabling CONFIG_4KSTACKS.  Also,
>>please add this to get a bit more info.
> 
> hi,
> 
> I'll try that. Should I do it with or without preemption?

The CONFIG_4KSTACKS is a more likely suspect than the preemption, actually.

When I read the post from Andrew I remembered some discussion about this 
and reiserfs, and searched my archives for it:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108680778325490&w=2

I would start with turning them both off to have a stable working system.

If after that you feel that your life is too boring and you want to live 
dangerously, you might try with CONFIG_PREEMPT=y. If you really want the 
full adrenaline rush, then go wild with CONFIG_PREEMPT_BKL=y too :)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
