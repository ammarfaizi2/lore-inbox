Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317020AbSGCOHr>; Wed, 3 Jul 2002 10:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSGCOHq>; Wed, 3 Jul 2002 10:07:46 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:24580 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317020AbSGCOHp>;
	Wed, 3 Jul 2002 10:07:45 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-reply-to: Your message of "Wed, 03 Jul 2002 22:27:33 +1000."
             <5813.1025699253@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 00:10:03 +1000
Message-ID: <6538.1025705403@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jul 2002 22:27:33 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>On Wed, 3 Jul 2002 00:31:35 -0700, 
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>      As individual space optimizations go, 4% is respectable,
>>especially for something that has no cost
>
>It is not at no cost.  Getting 4% requires arch dependent code to
>handle all the tables that are affected by partial text removal.  I can
>get 2% for nothing by discarding data.init.  Discarding text.init is a
>lot harder.

ps. That is not 4% of total memory.  It is 4% of the memory allocated
to modules.

If you loaded every single 2.5.24 module on ix86 they would occupy
23,527,424 bytes.

The additional memory saved by discarding both text.init and data.init,
compared to just the data.init, would be a mere 614,400 bytes.  If you
loaded every single module, which you would not do.

To get that saving requires patches against 17 architectures.  Some
architectures have multiple tables, each will require a patch.

Did I mention that I don't think the saving is worth the extra code
complexity in the kernel?

