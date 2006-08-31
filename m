Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWHaRig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWHaRig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWHaRig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:38:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:8908 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932390AbWHaRif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:38:35 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
To: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com
Reply-To: 7eggert@gmx.de
Date: Thu, 31 Aug 2006 19:32:24 +0200
References: <6OyEf-3Zm-5@gated-at.bofh.it> <6PCwg-3mz-43@gated-at.bofh.it> <6PDBU-5Qb-25@gated-at.bofh.it> <6PDBU-5Qb-23@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GIqPE-00010E-P2@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
> On Wednesday 30 August 2006 20:59, H. Peter Anvin wrote:
>> Alon Bar-Lev wrote:

>> > This is not entirely true...
>> > All architectures sets saved_command_line variable...
>> > So I can add __init to the saved_command_line and
>> > copy its contents into kmalloced persistence_command_line at
>> > main.c.
>> > 
>> 
>> My opinion is that you should change saved_command_line (which already
>> implies a copy) to be the kmalloc'd version and call the fixed-sized
>> buffer something else.
> 
> It might be safer to rename everything. Then all users could be caught
> and audited. This would ensure saved_command_line is not accessed
> before the kmalloc'ed copy exists.

If you set the new *saved_cmdline=saved_cmdline_init, the users don't need
to be adjusted at all, and you won't have trouble with code that may be
run before or after kmallocking (if it exists).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
