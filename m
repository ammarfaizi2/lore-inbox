Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVCNUYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVCNUYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVCNUYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:24:24 -0500
Received: from mail.aknet.ru ([217.67.122.194]:57358 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261856AbVCNUUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:20:51 -0500
Message-ID: <4235F230.8000106@aknet.ru>
Date: Mon, 14 Mar 2005 23:21:04 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-os@analogic.com, Jakob Eriksson <jakov@vmlinux.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>, wine-devel@winehq.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org> <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org> <423518A7.9030704@aknet.ru> <m14qfey3iz.fsf@muc.de> <4235AC0B.70507@vmlinux.org> <Pine.LNX.4.61.0503141158460.19270@chaos.analogic.com> <4235E4D5.5070506@didntduck.org>
In-Reply-To: <4235E4D5.5070506@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Brian Gerst wrote:
>> Can you tell me how the invisible high-word (invisible in VM-86, and
>> in real mode) could possibly harm something running in VM-86 or
>> read-mode ???  I don't even think it's a BUG. If the transition
>> into and out of VM-86 doesn't handle the fact that the high-word
>> of the stack hasn't been used in VM-86, then that piece of code
>> is bad (the SP isn't even the same stack, BTW).
> Because even in 16-bit mode (real, vm86 or 16-bit protected) you can use 
> 32-bit instructions, with an operand and/or address size override 
> prefix.
And the real problem is when the pure
32bit code is starting to use the 16bit
stack for some strange reasons. Looks like
the common technique for the early dos4gw
-based apps...

