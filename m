Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129833AbRBGHrV>; Wed, 7 Feb 2001 02:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbRBGHrL>; Wed, 7 Feb 2001 02:47:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129833AbRBGHq7>; Wed, 7 Feb 2001 02:46:59 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4 kernel & gcc code generation: a bug?
Date: 6 Feb 2001 23:46:28 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <95qugk$brs$1@cesium.transmeta.com>
In-Reply-To: <3A8108F8.2476.21D0F5@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A8108F8.2476.21D0F5@localhost>
By author:    "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
In newsgroup: linux.dev.kernel
> 
> You'll notice that %edx is not pushed at the start of the function. 
> Unless the caller saves that, edx will be spilled. Depending on the 
> level of optimization this can be bad. Am I wrong?
> 

Yes.  %eax, %edx and %ecx are defined as caller-saved registers.  Each
function is free to clobber them at will.

Now, if you saw the same for %ebx, %ebp, %esi or %edi, that would be
bad.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
