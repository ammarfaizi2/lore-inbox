Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317267AbSGCXGu>; Wed, 3 Jul 2002 19:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSGCXGt>; Wed, 3 Jul 2002 19:06:49 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:24069 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317267AbSGCXGs>;
	Wed, 3 Jul 2002 19:06:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-reply-to: Your message of "Wed, 03 Jul 2002 08:53:03 MST."
             <200207031553.IAA04513@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 09:09:10 +1000
Message-ID: <8834.1025737750@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002 08:53:03 -0700, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	I don't know enough about the formats of these tables right now
>to really understand the best way to handle them, but I suspect that
>the simplest approach might be a mechanism where copy_*_user and the like
>could generate assembler that does a .pushsection to a different section
>depending on the current section, so you could have "__ex_table" and
>".init.__ex_table", etc.

Unfortunately there is no way to get the current section name from
code.  I looked for one when I was trying to solve the __devexit
dangling pointer problem.

>	Come to think of it, if the core kernel's .text.init pages could
>later be vmalloc'ed for module .text section, then I think you may have
>found a potential kernel bug.

AFAICT that cannot occur.  The freed kernel .text.init pages are used
for kmalloc, not vmalloc.

