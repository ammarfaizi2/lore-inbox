Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUGLWCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUGLWCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUGLWCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:02:15 -0400
Received: from mail.tmr.com ([216.238.38.203]:65033 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263806AbUGLWBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:01:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Date: Mon, 12 Jul 2004 18:03:15 -0400
Organization: TMR Associates, Inc
Message-ID: <ccv1de$sq2$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org><E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1089669358 29506 192.168.12.100 (12 Jul 2004 21:55:58 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> Is doing memset(&(struct with_embeded_pointers), 0, sizeof(struct))
> also wrong?
> 
> I don't see that 0 is WRONG.  I do agree that ``((void *)0)'' is
> slightly more typesafe than ``0'', but since we don't have a lot of
> (void *) pointers in the kernel that is still the WRONG pointer type.
> 
> I do see that NULL has superior readability and maintainability and so
> should be encouraged by Documentation/CodingStyle.
> 
> The B and K&R roots of a simple single type language are what give C
> most of it's simplicity flexibility and power.  Please don't be so
> eager to throw those out.  
> 
> You want to be so typesafe it sounds like you want to recode the
> kernel in Pascal.  You've written sparse, so it should be just a little
> more work to write a Pascal backend.  After that the kernel will be so
> typesafe the compiler won't let us poor programmers get it wrong.

You say that as if it were a bad thing...

I don't have a current C standard handy, but I believe there's a 
requirement that otherwise uninitialized static pointers be initialized 
to NULL even if that isn't "all bits off."

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
