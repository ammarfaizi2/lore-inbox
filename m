Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUJTR2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUJTR2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUJTRWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:22:39 -0400
Received: from mail.aknet.ru ([217.67.122.194]:35085 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S268762AbUJTRPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:15:48 -0400
Message-ID: <41769F02.9020003@aknet.ru>
Date: Wed, 20 Oct 2004 21:23:14 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X does not start. vm86old returns ENOSYS??
References: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Denis Vlasenko wrote:
> How can vm86old from X return ENOSYS??
I think you can't trust what vm86()/vm86old()
returns, concerning strace. These 2 syscalls
returns different non-zero values on *success*,
which, I think, strace just doesn't get right.
Of course it can also return the reasonable
errors, like EFAULT as in your test program -
its just that copy_from_user() failed when
you specified NULL.
I am not sure where exactly the ENOSYS comes
from. My wild guess is that strace expects
0 on success and the negative value on error,
but any positive value is an indication that
the syscall is not implemented.
At least I've always seen ENOSYS in an strace
logs for vm86() - this is normal.

> I have no more ideas how to proceed from here.
Sorry for not being able to help much.

