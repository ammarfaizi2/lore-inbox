Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWEORPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWEORPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWEORPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:15:38 -0400
Received: from mail.aknet.ru ([82.179.72.26]:34566 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S964994AbWEORPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:15:38 -0400
Message-ID: <4468B733.7010101@aknet.ru>
Date: Mon, 15 May 2006 21:15:31 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Segfault on the i386 enter instruction
References: <44676F42.7080907@aknet.ru> <20060515074019.GA33242@muc.de>
In-Reply-To: <20060515074019.GA33242@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Andi Kleen wrote:
>> Aren't the rlimit and the other checks of acct_stack_growth()
>> not enough, or am I missing something obvious?
> Traditionally Linux doesn't have a stack ulimit.
That clarifies the roots of this %esp check, as without
the stack ulimit and without the proper memory accounting
(the case of 2.4?) such a check is the "last hope" - I've
got the point. But are there the reasons to still keep it
in 2.6, considering also the false-positives? It seems to
have the STACK_RLIMIT and it seems to get the memory accounting
right, and not too many arches seem to have such a check even.

