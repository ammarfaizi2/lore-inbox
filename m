Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLLVBH>; Tue, 12 Dec 2000 16:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbQLLVA5>; Tue, 12 Dec 2000 16:00:57 -0500
Received: from [195.224.55.237] ([195.224.55.237]:20211 "EHLO passion.cygnus")
	by vger.kernel.org with ESMTP id <S129413AbQLLVAp>;
	Tue, 12 Dec 2000 16:00:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0012102205190.11977-100000@web.sajt.cz> 
In-Reply-To: <Pine.LNX.4.21.0012102205190.11977-100000@web.sajt.cz> 
To: Pavel Rabel <pavel@web.sajt.cz>
Cc: ajapted@netspace.net.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdacon.c cleanup 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Dec 2000 09:15:11 +0000
Message-ID: <16970.976612511@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pavel@web.sajt.cz said:
> Both MODULE_PARM and __init are removed by precompiler when not
> compiler as module, so no need for ifdefs.  2.4.0-test12pre8

-#ifdef MODULE_PARM
 MODULE_PARM(mda_first_vc, "1-255i");
 MODULE_PARM(mda_last_vc,  "1-255i");
-#endif

That was #ifdef MODULE_PARM not #ifdef MODULE. Probably there for 
compatibility with older kernels. Although I'm not sure it's even required 
in 2.2.

And you seem to have forgotten to Cc the maintainer.  

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
