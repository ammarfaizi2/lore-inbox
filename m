Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135321AbRD3PIP>; Mon, 30 Apr 2001 11:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135344AbRD3PIF>; Mon, 30 Apr 2001 11:08:05 -0400
Received: from [64.64.109.142] ([64.64.109.142]:31494 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S135321AbRD3PHx>; Mon, 30 Apr 2001 11:07:53 -0400
Message-ID: <3AED7FA9.442F2F4E@didntduck.org>
Date: Mon, 30 Apr 2001 11:07:21 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 Oops
In-Reply-To: <20010430164631.A968@iapetus.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:
> 
> System is a dual PIII. Oops occurred while starting the automounter
> (autofs).  starting it later on by hand again gave no oops anymore.

[snip]

> Code;  c021b5f6 <__generic_copy_from_user+3a/64>   <=====
>    0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====

There should be no way for this to cause an oops.  There should be an
exception handler here that will catch the page fault and deal with it. 
It appears that the exception table might be corrupted.  What compiler
are you using?

--

				Brian Gerst
