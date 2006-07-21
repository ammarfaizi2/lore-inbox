Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWGUHpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWGUHpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 03:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWGUHpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 03:45:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:59591 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161014AbWGUHpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 03:45:42 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: why is intercepting system calls considerred bad?
To: Joshua Hudson <joshudson@gmail.com>, Irfan Habib <irfan.habib@gmail.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 21 Jul 2006 09:44:46 +0200
References: <6AVr2-6FS-3@gated-at.bofh.it> <6AVU0-7fw-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G3ph4-0000Z9-VV@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson <joshudson@gmail.com> wrote:
> On 7/20/06, Irfan Habib <irfan.habib@gmail.com> wrote:

>> I recently met a kernel janitor, who told me that intercepting system
>> calls is undesirable, why?
> 
> I'll bite.
> 
> You intercept. Somebody else intercepts. You want to stop intercepting.

Use a double-linked list.

Having a mechanism to intercept syscalls will slow down syscall processing,
and there was no legit user in the history of linux. If you need something
like that, there is ptrace.

> For this reason, anybody who intercepts a system call must be compiled
> in,

No, but they may need to be compiled in for other reasons.

> and if two intercept the same system call, than the link order
> dictates behavior.
> 
> Obviously not desirable.

ACK.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
